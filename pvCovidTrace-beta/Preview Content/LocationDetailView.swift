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
                
              
                //this can be fixed
                Text("make pv safe , check in where you had been depeding on your status, report to offical school network by the network globe button")
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                    .padding(.horizontal)
                
                
                ZStack{
                    Capsule()
                        .frame(height: 80)
                        .foregroundColor(Color(.secondarySystemBackground))
                
                    HStack(spacing: 70) {
                        Button {
                        } label: {
                    LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                        }
                        Link(destination: URL(string: "https://pvamu.co1.qualtrics.com/jfe/form/SV_cFHoR4fAzZLER1A")!, label:  {
                            
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
                
                LazyVGrid(columns: columns, content: {
                    AvatarView(size: 64)
                    AvatarView(size: 64)
                    AvatarView(size: 64)
                    AvatarView(size: 64)
                    AvatarView(size: 64)
                    AvatarView(size: 64)
                    AvatarView(size: 64)
                    AvatarView(size: 64)
                  
                    
                    
                })
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
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.white)

                    }
            }
        }
    }


struct AvatarView: View {
    var size: CGFloat
    
    var body: some View {
        Image("default-avatar")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
        
    }
}
