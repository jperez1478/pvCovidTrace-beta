//
//  PVProfile.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import Foundation
import CloudKit

struct PVProfile: Identifiable {
    static  let kFirstName   = "firstName"
    static let kLastName     = "lastName"
    static let kAvatar       = "avatar"
    static let kCovidStatus  = "covidStatus"
    static let kIsCheckedIn   = " isCheckedIn"
    
    let id: CKRecord.ID
    let firstName: String
    let lastName: String
    let avatar: CKAsset!
    let covidStatus: String
    let isCheckedIn: CKRecord.Reference? =  nil

    
    ///Member wise initiliazier

    init(record: CKRecord) {
        id = record.recordID
        firstName = record[PVProfile.kFirstName] as?  String ?? "N/A"
        lastName = record[PVProfile.kLastName] as? String ?? "N/A"
        avatar = record[PVProfile.kAvatar] as? CKAsset
        covidStatus = record[PVProfile.kCovidStatus] as? String ?? "N/A"
        
    }
    
}
