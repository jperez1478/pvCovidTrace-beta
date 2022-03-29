//
//  AppTabView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
           LocationMapView()
                .tabItem{
                    Label("Campus Map", systemImage: "map")
                }
            
            PVNewsView()
                .tabItem{
                    Label("PVNews", systemImage: "newspaper")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person")
                }
            LocationListView()
                .tabItem{
                    Label("Check In", systemImage: "building")
                }
            
        }
        .accentColor(.brandPrimary)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
