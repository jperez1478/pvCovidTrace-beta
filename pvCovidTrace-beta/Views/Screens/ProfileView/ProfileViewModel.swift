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
        
        // Get our UserRecordID from the Container
        CKContainer.default().fetchUserRecordID { recordID, error  in
            guard  let recordID =  recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            //Get UserRecord from the Public Database
            CKContainer.default().publicCloudDatabase.fetch(withRecordID:  recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                // Create refrence on UserRecord to the PVProfile we created
                userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
                
                // Create a CKOperarion to save  User and Profile Records
                //ARRAY of users to create
                let operation = CKModifyRecordsOperation(recordsToSave: [userRecord, profileRecord])
                //modifier for record
                operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
                    guard let savedRecords = savedRecords, error == nil else {
                        print(error!.localizedDescription)
                        return
                        
                    }
                    
                    //if records save print to test
                    print(savedRecords)
                }
                
                CKContainer.default().publicCloudDatabase.add(operation) //similar to url session like network call
            }
            
        }
        
    }
    
    
    
    //get user record to reference userID
    func getProfile(){
        CKContainer.default().fetchUserRecordID { recordID, error  in
            guard  let recordID =  recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            //Get UserRecord from the Public Database
            CKContainer.default().publicCloudDatabase.fetch(withRecordID:  recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                let  profileRefrence = userRecord["userProfile"] as! CKRecord.Reference
                let profileRecordID = profileRefrence.recordID
                
                CKContainer.default().publicCloudDatabase.fetch(withRecordID: profileRecordID) { profileRecord, error in
                    guard let profileRecord = profileRecord, error == nil else {
                        print(error!.localizedDescription)
                        
                        return
                    }
                    
                    //update UI
                    DispatchQueue.main.async { [self] in 
                        let profile = PVProfile(record: profileRecord)
                        firstName = profile.firstName
                        lastName = profile.lastName
                        covidStatus = profile.covidStatus
                    }
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
