//
//  LocationManager.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 4/1/22.
//

import MapKit
import SwiftUI

final class LocationManager: ObservableObject {
    @Published var locations: [PVLocations] = [] 
}
