//
//  MockData.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import Foundation
import CloudKit

struct MockData {
    
    static var location: CKRecord {
        let record = CKRecord(recordType: RecordType.location)
        record[PVLocations.kName] = "Architecture Building"
        record[PVLocations.kAdress] = "123 Main testing testing "
        record[PVLocations.kDescription] = "Testing testing "
        record[PVLocations.kWebsiteURL] = "https://pvamu.co1.qualtrics.com/jfe/form/SV_cFHoR4fAzZLER1A"
        record[PVLocations.kLocaton] = CLLocation(latitude: 37.328625, longitude: -121.891437)
        
        return record
    }
}
