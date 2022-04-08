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
