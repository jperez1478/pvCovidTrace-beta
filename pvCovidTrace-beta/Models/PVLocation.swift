//
//  PVLocation.swift
//  pvCovidTrace-beta
//
//
//

import Foundation
import CloudKit

struct PVLocation {
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
        name = record[PVLocation.rName] as?  String ?? "N/A"
        description = record[PVLocation.rName] as? String ?? "N/A"
        squareAsset = record[PVLocation.rSquareAsset] as? CKAsset
        bannerAsset = record[PVLocation.rBannerAsset] as? CKAsset
        adress = record[PVLocation.rAdress] as? String ?? "N/A"
        location = record[PVLocation.rLocaton] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL = record[PVLocation.rWebsiteURL] as? String ?? "N/A"
    }
    
}






