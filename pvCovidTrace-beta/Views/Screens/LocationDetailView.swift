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
    
    var location: PVLocations
    
    var body: some View {
        VStack(spacing: 16) {
            BannerImageView(image: location.createBannerImage())
        
            HStack {
                AdressView(adressString: location.adress)
                
                Spacer()
            }
            .padding(.horizontal)
            
            
            //this can be fixed
            DescriptionView(text: location.description)
            
            
            ZStack{
                Capsule()
                    .frame(height: 80)
                    .foregroundColor(Color(.secondarySystemBackground))
                
                HStack(spacing: 70) {
                    Button {
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                    }
                    Link(destination: URL(string: location.websiteURL)!, label:  {
                        
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
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}



struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LocationDetailView(location: PVLocations(record: MockData.location))
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
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
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
