//
//  LocationMapView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @StateObject private var viewModel = LocationMapViewModel()

    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region)
                .ignoresSafeArea()
            
            VStack {
               LogoView().shadow(radius: 10)
            
                Spacer()
            }
        }
        .alert(item: $viewModel.alertItem,content: { alertItem  in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dissmissButton)
            
        })
        
        .onAppear {
           
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

