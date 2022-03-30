//
//  PVLocations.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import Foundation
import CloudKit

struct PVLocations {
    static  let rName = "name"
    static let rDescription = "description"
   static let rSquareAsset = "squareAsset"
    static let  rBannerAsset = "bannerAsset"
    static let rAdress = "adress"
    static let rLocaton = "location"
    static let rWebsiteURL = "websiteURL"
    
    let ckRecordID: CKRecord.ID
    let name: String
    let description: String
    let squareAsset: CKAsset!
    let bannerAsset: CKAsset!
    let adress: String
    let location: CLLocation
    let websiteURL: String

    
    ///Member wise initiliazier

    init(record: CKRecord) {
        ckRecordID = record.recordID
        name = record[PVLocations.rName] as?  String ?? "N/A"
        description = record[PVLocations.rName] as? String ?? "N/A"
        squareAsset = record[PVLocations.rSquareAsset] as? CKAsset
        bannerAsset = record[PVLocations.rBannerAsset] as? CKAsset
        adress = record[PVLocations.rAdress] as? String ?? "N/A"
        location = record[PVLocations.rLocaton] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL = record[PVLocations.rWebsiteURL] as? String ?? "N/A"
    }
    
}






