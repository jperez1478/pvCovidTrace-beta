//
//  LocationDetailView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

struct LocationDetailView: View {
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())
    ]
    
    var locations: PVLocations
    
    var body: some View {
        VStack(spacing: 16) {
            BannerImageView(imageName: "Icon-1024-")
            
            HStack {
                AdressView(adressString: locations.adress)
                
                Spacer()
            }
            .padding(.horizontal)
            
            
            //this can be fixed
            DescriptionView(text:
                                locations.description)
            
            
            ZStack{
                Capsule()
                    .frame(height: 80)
                    .foregroundColor(Color(.secondarySystemBackground))
                
                HStack(spacing: 70) {
                    Button {
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                    }
                    Link(destination: URL(string: locations.websiteURL)!, label:  {
                        
                        Button {
                        } label: {
                            LocationActionButton(color: .brandPrimary, imageName: "network")
                        }
                    })
                    
                    
                    Button {
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "person.fill.checkmark")
                    }
                }
                
            }
            .padding(.horizontal)
            Text("Whos here?")
                .bold()
                .font(.title2)
           ///this allow for scroll view
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    FirstNameAvatarView(firstName: "sean")
                    FirstNameAvatarView(firstName: "sean")
                    FirstNameAvatarView(firstName: "sean")
                    FirstNameAvatarView(firstName: "sean")
                    FirstNameAvatarView(firstName: "sean")
                    
                    
                    
                    
                })
            }
            
          
            Spacer()
        }
        .navigationTitle(locations.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}



struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LocationDetailView(locations: PVLocations(record: MockData.location))
        }
       
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
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(.white)
                
            }
        }
    }
}



struct FirstNameAvatarView: View {
    var firstName: String
    var body: some View{
        VStack{
            AvatarView(size: 64)
            
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
            
        }
        
    }
}

struct BannerImageView: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct AdressView: View {
    var adressString: String
    
    var body: some View {
        Label(adressString, systemImage: "mappin.and.ellipse")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

struct DescriptionView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .frame(height: 70)
            .padding(.horizontal)
    }
}
