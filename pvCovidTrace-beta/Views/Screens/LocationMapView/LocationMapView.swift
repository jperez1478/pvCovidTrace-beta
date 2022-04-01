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
    
 // @StateObject private var viewModel = LocationMapViewModel()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:30.09349, longitude: -95.99029),
                                                   span: MKCoordinateSpan (latitudeDelta: 0.1, longitudeDelta: 0.1))
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
            
            VStack {
               LogoView().shadow(radius: 10)
            
                Spacer()
            }
        }
    //    .alert(item: $viewModel.alertItem,content: { alertItem  in
   //         Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dissmissButton)
            
//        })
        
        .onAppear {
            CloudKitManager.getLocations { result in
                switch result {
                    
                case .success(let locations):
                    print(locations)
                case .failure(let error ):
                    print(error.localizedDescription)
                }
                
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

