//
//  LocationMapViewModel.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import CloudKit
import MapKit
import SwiftUI

extension LocationMapView{
    
    final class LocationMapViewModel: ObservableObject {
        
        @Published var checkedInProfiles: [CKRecord.ID: Int] = [:]
        @Published var isShowingDetailView = false
        @Published var alertItem: AlertItem?
        @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.09233,
                                                                                    longitude:     -95.99029),
                                                                                     span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        
        

        
        func getLocations(for locationManager: LocationManager) {
            CloudKitManager.shared.getLocations { [self] result in
                DispatchQueue.main.async {
                    switch result {
                        case .success(let locations):
                            locationManager.locations = locations
                        case .failure(_):
                            alertItem = AlertContext.unableToGetLocations
                    }
                }
            }
        }
        
        func getCheckedInCounts(){
            CloudKitManager.shared.getCheckedInProfilesCount{ result in
                DispatchQueue.main.async { [self] in
                    switch result{
                    case .success(let checkedInProfiles):
                        self.checkedInProfiles = checkedInProfiles
                    case.failure(_):
                        alertItem = AlertContext.checkedInCount
                    break
                    }
                }
                
            }
        }
        
        @ViewBuilder func createLocationDetailView(for location: PVLocations, in dynamicTypeSize: DynamicTypeSize) -> some View {
            if dynamicTypeSize >= .accessibility3 {
                LocationDetailView(viewModel: LocationDetailViewModel(location: location)).embedInScrollView()
            } else {
                LocationDetailView(viewModel: LocationDetailViewModel(location: location))
            }
        }
    }
}

