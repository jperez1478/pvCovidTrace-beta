//
//  ProfileViewModel.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 4/7/22.
//

import CloudKit

final class ProfileViewModel: ObservableObject {
    @Published var firstName         = ""
    @Published var lastName           = ""
    @Published var covidStatus      = ""
    @Published var avatar              =  PlaceholderImage.avatar
    @Published var alertItem:       AlertItem?
        
    
    
    func isValidProfile() -> Bool {
        guard   !firstName.isEmpty,
                   !lastName.isEmpty,
                  !covidStatus.isEmpty,
                 covidStatus.count < 20 else { return false }
        
        return true
    }
    
    func createProfile() {
        guard isValidProfile()  else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        // Create our CKRecord from the profileView
        let profileRecord = createProfileRecord()
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            //show alert
            
            return
        }
        
      
        // Create refrence on UserRecord to the PVProfile we created
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
       
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            switch result {
            case .success(_):
                //show laert
                break
                
            case .failure(_):
                break
            }
        }
        
    }
    
    
    
    //get user record to reference userID
    func getProfile(){
        guard let userRecord = CloudKitManager.shared.userRecord else {
            //show alert
            
            return
        }
        
       guard  let profileRefrence = userRecord["userProfile"] as? CKRecord.Reference else {
            //show alert
            return
       }
        
       let profileRecordID = profileRefrence.recordID
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result  in
            DispatchQueue.main.async { [self] in
            switch result {
                
            case .success(let record):
                //update UI
              
                    let profile = PVProfile(record: record)
                    firstName = profile.firstName
                    lastName = profile.lastName
                    covidStatus = profile.covidStatus
                
            case .failure(_):
                //show alert
                break
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
    
}
