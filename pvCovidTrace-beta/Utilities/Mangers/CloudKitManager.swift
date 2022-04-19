//
//  CloudKitManager.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import CloudKit

final class CloudKitManager {
    static let shared = CloudKitManager()
    
    private init() {}
    
    var userRecord: CKRecord?
    var profileRecordID: CKRecord.ID?
    
    func getUserRecord() {
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
                
                self.userRecord = userRecord
 //               self.profileRecordID = userRecord.creatorUserRecordID
                
                if let profileRefrence = userRecord["userProfile"] as? CKRecord.Reference {
                    self.profileRecordID = profileRefrence.recordID
                }
             
            
            }
        }
    }
    
    
     func getLocations(completed: @escaping(Result<[PVLocations], Error>) -> Void) {
        let sortDescriptor = NSSortDescriptor(key: PVLocations.kName, ascending: true)
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
    //    query.sortDescriptors = [sortDescriptor]
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil)  {  records, error in
            guard error == nil else {
                completed(.failure(error!))
                return
            }
            
            guard let records = records else { return }
                
            let locations = records.map { $0.convertToPVLocations()}
            
            completed(.success(locations))
        }
    }
    
    //Get the checked in profiles from the database
    func getCheckedInProfiles(for locationID: CKRecord.ID, completed: @escaping (Result<[PVProfile], Error>) -> Void){
        let reference = CKRecord.Reference(recordID: locationID, action: .none)
        let predicate = NSPredicate(format: "isCheckedIn == %@", reference)
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil){records, error in
            guard let records = records, error == nil else {
                completed(.failure(error!))
                return
            }
            
            let profiles = records.map { $0.convertToPVProfile()}
            completed(.success(profiles))
        }
        
    }
    
    func getCheckedInProfilesDictionary(completed: @escaping (Result<[CKRecord.ID:[PVProfile]], Error>) -> Void){
        let predicate = NSPredicate(format: "isCheckedInNilCheck == 1")
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        let operation = CKQueryOperation(query: query)
//        operation.desiredKeys = [PVProfile.kIsCheckedIn, PVProfile.kAvatar]
        
        var checkedInProfiles: [CKRecord.ID: [PVProfile]] = [:]
        
        operation.recordFetchedBlock = { record in
            //Build our dictionary
            let profile = PVProfile(record: record)
            
            guard let locationReference = profile.isCheckedIn else {return}
            
            checkedInProfiles[locationReference.recordID, default: []].append(profile)
        }
        
        operation.queryCompletionBlock = {cursor, error in
            guard error == nil else{
                completed(.failure(error!))
                return
            }
            completed(.success(checkedInProfiles))
            
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func getCheckedInProfilesCount(completed: @escaping (Result<[CKRecord.ID: Int], Error>) -> Void){
        let predicate = NSPredicate(format: "isCheckedInNilCheck == 1")
        let query = CKQuery(recordType: RecordType.profile, predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.desiredKeys = [PVProfile.kIsCheckedIn]
        
        var checkedInProfiles: [CKRecord.ID: Int] = [:]
        
        operation.recordFetchedBlock = { record in
            //Build our dictionary
            guard let locationReference = record[PVProfile.kIsCheckedIn] as? CKRecord.Reference else {return}
            
            if let count = checkedInProfiles[locationReference.recordID]{
                checkedInProfiles[locationReference.recordID] = count + 1
            }else{
                checkedInProfiles[locationReference.recordID] = 1
            }
        }
        
        operation.queryCompletionBlock = {cursor, error in
            guard error == nil else{
                completed(.failure(error!))
                return
            }
            completed(.success(checkedInProfiles))
            
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    
    func batchSave(records: [CKRecord], completed: @escaping (Result<[CKRecord], Error>) -> Void) {
        
        let operation = CKModifyRecordsOperation(recordsToSave: records)
        //modifier for record
        operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
            guard let savedRecords = savedRecords, error == nil else {
                print(error!.localizedDescription)
                completed(.failure(error!))
                return
            }
            
            completed(.success(savedRecords))
            }
        
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    func save(record: CKRecord, completed: @escaping (Result<CKRecord, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.save(record) { record, error in
            guard let record = record, error == nil else {
                completed(.failure(error!))
                return
            }
            
            completed(.success(record))
        }
    }
    
    func fetchRecord(with id: CKRecord.ID, completed: @escaping (Result<CKRecord, Error>) -> Void) {
        //Get UserRecord from the Public Database
        CKContainer.default().publicCloudDatabase.fetch(withRecordID:  id) { record, error in
            guard let record = record, error == nil else {
                completed(.failure(error!))
                return
            }
            
            completed(.success(record))

    }
}
}
