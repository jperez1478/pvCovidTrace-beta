//
//  LocationListView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI
import CloudKit

struct LocationListView: View {
    @State private var locations: [PVLocation] = [PVLocation(record: MockData.location)]
    
    var body: some View {
        NavigationView{
            List {
                ForEach(locations, id: \.ckRecordID) { location  in
                    NavigationLink(destination: LocationDetailView(locations: location)) {
                        LocationCell(location:  location)
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


