//
//  LocationDetailViewModel.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 4/8/22.
//

import SwiftUI
import MapKit
import CloudKit


enum CheckInStatus { case checkedIn, checkedOut }

final class LocationDetailViewModel: ObservableObject {
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var location: PVLocations
    
    init(location: PVLocations) {
        self.location = location
    }
    
    func getDirectionsToLocation() {
        let placemark = MKPlacemark(coordinate: location.location.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = location.name
        
    
        
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey:  MKLaunchOptionsDirectionsModeWalking])
    }
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        // retrieve pvprofile
        
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            
            //show alert
            return
        }
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { [self] result  in
            switch result {
                case .success(let record):
                //create a refrence to the location
                switch checkInStatus {
                case .checkedIn:
                    record[PVProfile.kIsCheckedIn] = CKRecord.Reference(recordID: location.id, action: .none)
                case .checkedOut:
                    record[PVProfile.kIsCheckedIn]  = nil
                }
                //save update profile to cloudkit
                CloudKitManager.shared.save(record: record) { result  in
                    switch result {
                        
                    case .success(_):
                        //update our checkedin profle array
                        print("checked in/out succesfully")
                    case .failure(_):
                        print("error saving record ")
                    }
                }
            case .failure(_):
                print("error saving record")
            }
        }
        


        
        
        
        
    }
    
    
}
