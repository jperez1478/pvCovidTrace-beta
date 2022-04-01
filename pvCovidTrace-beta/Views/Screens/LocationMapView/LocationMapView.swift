//
//  LocationMapView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI
import MapKit
import CloudKit

struct LocationMapView: View {
    
 
@EnvironmentObject private var locationManager: LocationManager
 @StateObject private var viewModel = LocationMapViewModel()
  
 
    var body: some View {
        ZStack {
            
          
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
                
                MapMarker(coordinate: location.location.coordinate, tint: .brandPrimary)
                
                
            }
                .ignoresSafeArea()
            
            VStack {
               LogoView().shadow(radius: 10)
            
                Spacer()
            }
        }
         
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dissmissButton)
            
        })
        
        .onAppear {
            viewModel.checkIfLocationServicesIsEnabled()
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
                    
            }
            
            }
        }
    }
    


struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
    }
}

struct LogoView: View {
    var body: some View {
        Image("pvmap")
            .resizable()
            .scaledToFit()
            .frame(height: 70)
            
    }
}

