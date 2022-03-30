//
//  PVProfile.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import Foundation
import CloudKit

struct PVProfile {
    static  let rFirstName = "firstName"
    static let rLastName = "lastName"
    static let rAvatar = "Avatar"
  static let rCovidStatus = "covidStatus"
    static let rIsCheckedIn = " isCheckedIn"
    
    let ckRecordID: CKRecord.ID
    let firstName: String
    let lastName: String
    let avatar: CKAsset!
    let covidStatus: String
    let isCheckedIn: CKRecord.Reference? =  nil

    
    ///Member wise initiliazier

    init(record: CKRecord) {
        ckRecordID = record.recordID
        firstName = record[PVProfile.rFirstName] as?  String ?? "N/A"
       lastName = record[PVProfile.rLastName] as? String ?? "N/A"
        avatar = record[PVProfile.rAvatar] as? CKAsset
        covidStatus = record[PVProfile.rCovidStatus] as? String ?? "N/A"
        
    }
    
}
