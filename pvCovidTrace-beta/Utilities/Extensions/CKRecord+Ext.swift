//
//  CKRecord+Ext.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import CloudKit

extension CKRecord {
    func convertToPVLocations() -> PVLocations { PVLocations(record: self)}
    func convertToPVProfile() -> PVProfile { PVProfile(record: self)}
            
    
    }
