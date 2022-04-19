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
    
    var placeholder: UIImage {
        switch self {
        case .square:
            return PlaceholderImage.square
        case .banner:
            return PlaceholderImage.banner
        }
        
    }
}


enum DeviceTypes {
    enum ScreenSize {
        static let width                = UIScreen.main.bounds.size.width
        static let height               = UIScreen.main.bounds.size.height
        static let maxLength            = max(ScreenSize.width, ScreenSize.height)
    }
    
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale


    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale


}
