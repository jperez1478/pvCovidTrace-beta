//
//  PVLocations.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import Foundation
import CloudKit
import UIKit

struct PVLocations: Identifiable {
    
    static let kName = "name"
    static let kDescription = "description"
    static let kSquareAsset = "squareAsset"
    static let  kBannerAsset = "bannerAsset"
    static let kAdress = "adress"
    static let kLocaton = "location"
    static let kWebsiteURL = "websiteURL"
    static let kPostiveCases = "positiveCases"
    
    let id: CKRecord.ID
    let name: String
    let description: String
    let squareAsset: CKAsset!
    let bannerAsset: CKAsset!
    let adress: String
    let location: CLLocation
    let websiteURL: String
    let positiveCases: String!

    
    ///Member wise initiliazier

    init(record: CKRecord) {
        id = record.recordID
        name = record[PVLocations.kName] as?  String ?? "N/A"
        description = record[PVLocations.kDescription] as? String ?? "N/A"
        squareAsset = record[PVLocations.kSquareAsset] as? CKAsset
        bannerAsset = record[PVLocations.kBannerAsset] as? CKAsset
        adress = record[PVLocations.kAdress] as? String ?? "N/A"
        location = record[PVLocations.kLocaton] as? CLLocation ?? CLLocation(latitude: 0, longitude: 0)
        websiteURL = record[PVLocations.kWebsiteURL] as? String ?? "N/A"
        positiveCases = record[PVLocations.kPostiveCases] as? String ?? "N/A"
    }
    
    var squareImage: UIImage {
        guard let asset = squareAsset else { return PlaceholderImage.square }
        return asset.converToUIImage(in: .square)
    }
    
    var bannerImage: UIImage {
        guard let asset = bannerAsset else { return PlaceholderImage.banner }
        return asset.converToUIImage(in: .banner)
    }
}






