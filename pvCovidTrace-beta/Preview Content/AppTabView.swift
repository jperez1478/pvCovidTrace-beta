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
                    Label("Map", systemImage: "map")
                }
            
            LocationListView()
                .tabItem{
                    Label("Check In", systemImage: "building")
                }
        
            PVNewsView()
                .tabItem{
                    Label("News", systemImage: "newspaper")
                }
            NavigationView {
                ProfileView()
            }
                .tabItem{
                    Label("Profile", systemImage: "person")
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
