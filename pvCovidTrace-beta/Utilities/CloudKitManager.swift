//
//  CloudKitManager.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import CloudKit

struct CloudKitManager {
    static func getLocations(completed: @escaping(Result<[PVLocation], Error>) -> Void) {
        let sortDescriptor = NSSortDescriptor(key: PVLocation.rName, ascending: true)
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        query.sortDescriptors = [sortDescriptor]
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil)  {  records, error in
            guard error == nil else {
                completed(.failure(error!))
                return
            }
            
            guard let records = records else { return }
            var locations: [PVLocation] = []
            
            for record in records {
                let location = PVLocation(record: record)
                locations.append(location)
            }
            
            completed(.success(locations))

        }
        
    }
}
