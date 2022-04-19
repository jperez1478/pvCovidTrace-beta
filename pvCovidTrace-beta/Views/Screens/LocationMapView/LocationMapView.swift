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
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
  
 
    var body: some View {
        ZStack (alignment: .top) {
            
          
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
                
                MapAnnotation(coordinate: location.location.coordinate, anchorPoint:CGPoint(x: 0.5, y: 0.5)){
                    PVAnnotation(location: location,
                                 number: viewModel.checkedInProfiles[location.id, default: 0])
                        .onTapGesture {
                            locationManager.selectedlocation = location
                            viewModel.isShowingDetailView = true
                        }
                }
                
                
            }
            .accentColor(.red)
            .ignoresSafeArea()
            
               LogoView(frameWidth: 125).shadow(radius: 10)
        }
        
        .sheet(isPresented: $viewModel.isShowingDetailView){
            NavigationView{
                viewModel.createLocationDetailView(for: locationManager.selectedlocation!, in: dynamicTypeSize)
                    .toolbar{
                        Button("Dismiss", action: {viewModel.isShowingDetailView = false})
                    }
            }


        }
         
        .alert(item: $viewModel.alertItem, content: { $0.alert })
        
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
        LocationMapView().environmentObject(LocationManager())
    }
}

