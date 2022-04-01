//
//  LocationListView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI
import CloudKit

struct LocationListView: View {
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        NavigationView{
            List {
                ForEach(locationManager.locations) {  location   in
                    NavigationLink(destination: LocationDetailView(location: location)) {
                        LocationCell(location: location)
                    }
                        
                    }
            }
                .navigationTitle("PV Locations")
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}


