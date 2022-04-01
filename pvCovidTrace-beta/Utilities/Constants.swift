//
//  Constants.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import Foundation
import UIKit

enum RecordType {
    static let location = "PVLocations"
    static let profile = "PVProfile"
    
}

enum PlaceholderImage {
    static let avatar = UIImage(named: "default-avatar")!
    static let square = UIImage(named: "university view")!
    static let banner = UIImage(named: "Icon-1024-")!
}

enum ImageDimension {
    case square, banner
    
   static  func getPlaceholder(for dimension: ImageDimension) -> UIImage {
        switch dimension {
        case .square:
            return PlaceholderImage.square
        case .banner:
            return PlaceholderImage.banner
        }
        
    }
}
