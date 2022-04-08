//
//  LocationDetailViewModel.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 4/8/22.
//

import SwiftUI
import MapKit

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
    
    
    
}
