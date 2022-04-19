//
//  ProfileViewModel.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 4/7/22.
//

import CloudKit

enum ProfileContext { case create, update }

extension ProfileView {
    final class ProfileViewModel: ObservableObject {
        @Published var firstName        = ""
        @Published var lastName         = ""
        @Published var covidStatus      = ""
        @Published var avatar           =  PlaceholderImage.avatar
        @Published var alertItem:       AlertItem?
        
        
        @Published var isLoading = false
        @Published var isCheckedIn = false
        
        private var existingProfileRecord: CKRecord? {
            didSet { profileContext = .update }
        }
        var profileContext: ProfileContext = .create
            
        
        
        func isValidProfile() -> Bool {
            guard   !firstName.isEmpty,
                       !lastName.isEmpty,
                      !covidStatus.isEmpty,
                     covidStatus.count < 20 else { return false }
            
            return true
        }
        
        func getCheckedInStatus(){
            guard let profileRecordID = CloudKitManager.shared.profileRecordID else {return}
            
            CloudKitManager.shared.fetchRecord(with: profileRecordID) {[self] result in
                DispatchQueue.main.async { [self] in
                    switch result{
                    case .success(let record):
                        if record[PVProfile.kIsCheckedIn] is CKRecord.Reference{
                            isCheckedIn = true
                            
                        } else{
                            isCheckedIn = false
                        }
                    case .failure(_):
                        break
                        
                    }
                }
                
            }
        }
        func checkOut(){
            guard let profileID = CloudKitManager.shared.profileRecordID else{
                alertItem = AlertContext.unableToGetProfile
                return
            }
            CloudKitManager.shared.fetchRecord(with: profileID){ result in
                switch result {
                case .success(let record):
                    record[PVProfile.kIsCheckedIn] = nil
                    record[PVProfile.kIsCheckedInNilCheck] = nil
                    
                    CloudKitManager.shared.save(record: record) { [self] result in
                        DispatchQueue.main.async { [self] in
                            switch result{
                            case .success(_):
                                isCheckedIn = false
                            case .failure(_):
                                alertItem = AlertContext.unableToCheckInorOut
                            }
                        }
                        
                    }
                case .failure(_):
                    DispatchQueue.main.async {self.alertItem = AlertContext.unableToCheckInorOut}
                    
                }
            }
        }
        
        func createProfile() {
            guard isValidProfile()  else {
                alertItem = AlertContext.invalidProfile
                return
            }
            
            // Create our CKRecord from the profileView
            let profileRecord = createProfileRecord()
            
            guard let userRecord = CloudKitManager.shared.userRecord else {
                alertItem = AlertContext.noUserRecord
                
                return
            }
            
          
            // Create refrence on UserRecord to the PVProfile we created
            userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
           
            
            showLoadingView()
            CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
                DispatchQueue.main.async { [self] in
                    hideLoadingView()
                    
                    switch result {
                    case .success(let records):
                        for record in records where record.recordType ==  RecordType.profile {
                            existingProfileRecord = record
                            CloudKitManager.shared.profileRecordID = record.recordID
                            
                        }
                        
                        alertItem = AlertContext.createProfileSuccess
                    case .failure(_):
                        alertItem = AlertContext.createProfileFailure
                        break
                    }
                }
            }
            
        }
        
        
        
        //get user record to reference userID
        func getProfile(){
            guard let userRecord = CloudKitManager.shared.userRecord else {
                alertItem = AlertContext.noUserRecord
                return
            }
            
           guard  let profileRefrence = userRecord["userProfile"] as? CKRecord.Reference else {
                //show alert
                return
           }
            
           let profileRecordID = profileRefrence.recordID
            
            showLoadingView()
            CloudKitManager.shared.fetchRecord(with: profileRecordID) { result  in
                DispatchQueue.main.async { [self] in
                    hideLoadingView()
                    switch result {
                    
                    case .success(let record):
                        existingProfileRecord =  record
                       let profile = PVProfile(record: record)
                        firstName = profile.firstName
                        lastName = profile.lastName
                        covidStatus = profile.covidStatus
                    
                case .failure(_):
                        alertItem = AlertContext.unableToGetProfile
                        break
                }
            }
            
            }
        }
            
            func updateProfile() {
                guard isValidProfile() else {
                    alertItem = AlertContext.invalidProfile
                    return
                }
                
                guard let  profileRecord  = existingProfileRecord else {
                    alertItem = AlertContext.unableToGetProfile
                    return
                }
            
                
                profileRecord[PVProfile.kFirstName]         = firstName
                profileRecord[PVProfile.kLastName]          =  lastName
                profileRecord[PVProfile.kCovidStatus]       = covidStatus
                
                showLoadingView()
                CloudKitManager.shared.save(record: profileRecord) { result  in
                    DispatchQueue.main.async { [self] in
                        hideLoadingView()
                        switch result {
                            case .success(_):
                                alertItem = AlertContext.updateProfileSuccess
                            
                            case .failure(_):
                                alertItem = AlertContext.updateProfileFailure
                        }
                    }
                }
            }

           private func createProfileRecord() -> CKRecord {
            
            let profileRecord = CKRecord(recordType: RecordType.profile)
            profileRecord[PVProfile.kFirstName]         = firstName
            profileRecord[PVProfile.kLastName]          =  lastName
            profileRecord[PVProfile.kCovidStatus]       = covidStatus
            
            return profileRecord
            
        }
        
        private func showLoadingView() { isLoading = true }
          
        private func  hideLoadingView() { isLoading = false }
            
    }

}
