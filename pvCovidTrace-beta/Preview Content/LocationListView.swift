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

struct LocationCell: View {
    
    
    var body: some View {
        
            HStack {
                Image("library")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .clipShape(Rectangle())
                    .padding(.vertical, 8)
                
                VStack(alignment: .leading) {
                    Text("PVAMU Library")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.75)
                    
                    HStack {
                        Text("Check in ")
                            .minimumScaleFactor(0.75)
                    }
                }
                
                .padding(.leading)
            }
            
        }
    }

