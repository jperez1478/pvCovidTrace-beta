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
        record[PVLocation.rName] = "Architecture Building"
        record[PVLocation.rAdress] = "123 Main street"
        record[PVLocation.rDescription] = "Thi sis a test description "
        record[PVLocation.rWebsiteURL] = "https://pvamu.co1.qualtrics.com/jfe/form/SV_cFHoR4fAzZLER1A"
        record[PVLocation.rLocaton] = CLLocation(latitude: 37.328625, longitude: -121.891437)
        
        return record
    }
}
