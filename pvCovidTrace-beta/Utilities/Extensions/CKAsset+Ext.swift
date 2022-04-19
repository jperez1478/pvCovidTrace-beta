//
//  CKAsset+Ext.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 4/1/22.
//

import CloudKit
import UIKit

extension CKAsset {
    func converToUIImage(in dimension: ImageDimension) -> UIImage {
        
        guard let fileUrl = self.fileURL else { return dimension.placeholder }
    
        
        do  {
            let data = try  Data(contentsOf: fileUrl)
            return UIImage(data: data) ?? dimension.placeholder
        } catch  {
            return dimension.placeholder
            }
        
    }
    
}
