//
//  AppTabView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

struct AppTabView: View {
    
    @StateObject private var viewModel = AppTabViewModel()
    
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
        .onAppear {
            CloudKitManager.shared.getUserRecord()
            viewModel.runStartUpChecks()
        }
        .sheet(isPresented: $viewModel.isShowingOnBoardView, onDismiss: viewModel.checkIfLocationServicesIsEnabled){
            OnboardingView()
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
