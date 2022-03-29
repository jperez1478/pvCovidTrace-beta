//
//  LocationDetailView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

struct LocationDetailView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Image("Icon-1024-")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                
                HStack {
                    Label("123 Main Street", systemImage: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
              
                
                Text("This is a test description. This is a test description. This is a test description. This is a test description. This is a test description.")
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                    .padding(.horizontal)
                
                
                ZStack{
                    Capsule()
                        .frame(height: 80)
                        .foregroundColor(Color(.secondarySystemBackground))
                
                    HStack {
                        Button {
                        } label: {
                    LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                        }
                    }
                
                }
                .padding(.horizontal)
                Spacer()
    }
        .navigationTitle("LocationName")
        .navigationBarTitleDisplayMode(.inline)
}
        
    }
}


struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailView()
    }
}

struct LocationActionButton: View {
    var color: Color
    var imageName: String
    var body: some View {
 
            HStack{
                ZStack{
                    Circle()
                        .foregroundColor(color)
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: imageName)
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.white)

                    }
            }
        }
    }

