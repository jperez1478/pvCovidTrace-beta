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
    @Published var checkedInProfiles: [PVProfile] = []
    @Published var isCheckedIn = false
    @Published var isLoading = false
    @Published var alertItem: AlertItem?
    
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
    
    func getCheckedInStatus(){
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {return}
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) {[self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let record):
                    if let reference = record[PVProfile.kIsCheckedIn] as? CKRecord.Reference{
                        isCheckedIn = reference.recordID == location.id
                    } else{
                        isCheckedIn = false
                    }
                case .failure(_):
                    alertItem = AlertContext.unableToGetCheckInStatus
                    
                }
            }
            
        }
    }
    
    func updateCheckInStatus(to checkInStatus: CheckInStatus) {
        // retrieve pvprofile
        
        guard let profileRecordID = CloudKitManager.shared.profileRecordID else {
            
            //show alert
            alertItem = AlertContext.unableToGetProfile
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
                    DispatchQueue.main.sync {
                        switch result {
                            // Upon sucess of able to check into a location
                            case .success(let record):
                            let profile = PVProfile(record: record)
                            switch checkInStatus {
                            case .checkedIn:
                                    checkedInProfiles.append(profile)
                            case .checkedOut:
                                   checkedInProfiles.removeAll(where: {$0.id == profile.id})
                                }
                            isCheckedIn = checkInStatus == .checkedIn
                            
                            //update our checkedin profle array

                        case .failure(_):
                            alertItem = AlertContext.unableToCheckInorOut
                        }
                    }
                }
            case .failure(_):
                alertItem = AlertContext.unableToCheckInorOut
            }
        }
        
    }
    //Function for checked in profies
    func getCheckedInProfiles(){
        showLoadingView()
        CloudKitManager.shared.getCheckedInProfiles(for: location.id) { [self] result in
            DispatchQueue.main.async {
                switch result{
                    
                case .success(let profiles):
                    checkedInProfiles = profiles
                case .failure(_):
                    alertItem = AlertContext.unableToGetCheckedInProfiles
                }
                
                hideLoadingView()
            }
            
        }
    }
    private func showLoadingView() { isLoading = true }
      
    private func  hideLoadingView() { isLoading = false }
    
}
