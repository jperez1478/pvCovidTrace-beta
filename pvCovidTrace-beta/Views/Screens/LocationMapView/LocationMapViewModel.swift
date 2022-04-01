//
//  LocationMapViewModel.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import Foundation
import MapKit

final class LocationMapViewModel: ObservableObject {
    @Published   var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.09233,
                                                                                longitude:     -95.99029),
                                                                                 span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    @Published  var alertItem: AlertItem?
    
    @Published var locations: [PVLocations] = []
    
    func getLocations() {
        CloudKitManager.getLocations { [self] result in
            switch result {
                case.success(let locations) :
                self.locations = locations
            case.failure(_):
                alertItem = AlertContext.unableToGetLocations
        
    }
        }
}
}
