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
    
 
    @EnvironmentObject  private var locationManager: LocationManager
    @StateObject        private var viewModel = LocationMapViewModel()
    @Environment(\.sizeCategory) var sizeCategory
  
 
    var body: some View {
        ZStack {
            
          
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
                
                MapAnnotation(coordinate: location.location.coordinate, anchorPoint:CGPoint(x: 0.5, y: 0.5)){
                    PVAnnotation(location: location,
                                 number: viewModel.checkedInProfiles[location.id, default: 0])
                        .accessibilityLabel(Text("Map Pin \(location.name) \(viewModel.checkedInProfiles[location.id, default: 0]) people checked in."))
                        .onTapGesture {
                            locationManager.selectedlocation = location
                            viewModel.isShowingDetailView = true
                        }
                }
                
                
            }
            .accentColor(.userlocation)
                .ignoresSafeArea()
            
            VStack {
               LogoView(frameWidth: 125)
                    .shadow(radius: 10)
//                    .accessibilityHidden(true)
            
                Spacer()
            }
        }
        
        .sheet(isPresented: $viewModel.isShowingDetailView){
            NavigationView{
                viewModel.createLocationDetailView(for: locationManager.selectedlocation!, in: sizeCategory)
                    .toolbar{
                        Button("Dismiss", action: {viewModel.isShowingDetailView = false})
                    }
            }
            .accentColor(.brandPrimary)

        }
         
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dissmissButton)
            
        })
        
        .onAppear {
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
            }
            viewModel.getCheckedInCounts()
            
            }
        }
    }
    


struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView()
    }
}

