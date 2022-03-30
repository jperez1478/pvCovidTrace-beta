//
//  LocationListView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

struct LocationListView: View {
    var body: some View {
        NavigationView{
            List {
                ForEach(0..<10) { item in
                    NavigationLink(destination: LocationDetailView()) {
                        LocationCell()
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


