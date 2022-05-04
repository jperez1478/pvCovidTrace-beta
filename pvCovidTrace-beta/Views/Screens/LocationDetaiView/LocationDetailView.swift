//
//  LocationDetailView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

struct LocationDetailView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    
    var body: some View {
        VStack(spacing: 16) {
            BannerImageView(image: viewModel.location.bannerImage)
            AdressHStack(adressString: viewModel.location.adress)
            DescriptionView(text: viewModel.location.description)
            ActionButtonHStack(viewModel: viewModel)
            GridHeaderTextView(number: viewModel.checkedInProfiles.count)
            AvatarGridView(viewModel: viewModel)
            Spacer()
        }
        .navigationTitle(viewModel.location.name)
        .navigationBarTitleDisplayMode(.inline)

    }
    
}



struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LocationDetailView(viewModel: LocationDetailViewModel(location: PVLocations(record: MockData.location)))
        }
    }
}

fileprivate struct LocationActionButton: View {
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



fileprivate struct FirstNameAvatarView: View {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    var profile: PVProfile
    
    var body: some View{
        VStack{
            AvatarView(size: dynamicTypeSize >= .accessibility3 ? 100 : 64)
            
            Text("user")  //user name 
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
            
        }
        
    }
}

fileprivate struct BannerImageView: View {
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
            .accessibilityHidden(true)
    }
}

fileprivate struct AdressHStack: View {
    var adressString: String
    
    var body: some View {
        HStack{
            Label(adressString, systemImage: "mappin.and.ellipse")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

fileprivate struct DescriptionView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .minimumScaleFactor(0.75)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
    }
}

fileprivate struct ActionButtonHStack: View {

    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
        HStack(spacing: 70) {
            Button {
                viewModel.getDirectionsToLocation()
            } label: {
                
                LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                    .accessibilityLabel(Text("Get directions"))
            }
            Link(destination: URL(string: viewModel.location.websiteURL)!, label:  {
                
                Button {
                } label: {
                    LocationActionButton(color: .brandPrimary, imageName: "network")
                }
                .accessibilityLabel(Text("Go to Website"))
            })
            
            Button {
                viewModel.updateCheckInStatus(to: viewModel.isCheckedIn ? .checkedOut: .checkedIn)
            } label: {
                LocationActionButton(color: viewModel.buttonColor, imageName: viewModel.buttonImageTitle)
            }
            .accessibilityLabel(Text(viewModel.buttonA11yLabel))
            .disabled(viewModel.isLoading)
            
            
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom:10, trailing: 20))
        .background(Color(.secondarySystemBackground))
        .clipShape(Capsule())
        
    }
}

fileprivate struct GridHeaderTextView: View {
    
    var number: Int
    
    var body: some View {
        Text("Whos here?")
            .bold()
            .font(.title2)
            .accessibility(addTraits: .isHeader)
            .accessibilityLabel(Text("Who's Here? \(number) checked in"))
            .accessibilityHint(Text("Bottom section is scrollable"))
    }
}

fileprivate struct GridEmptyStateTextView: View {
    var body: some View {
        Text("Nobody's Here")
            .bold()
            .font(.title2)
            .foregroundColor(.secondary)
            .padding(.top, 30)
    }
}

fileprivate struct AvatarGridView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        ZStack{
            if viewModel.checkedInProfiles.isEmpty{
                GridEmptyStateTextView()
            }else {
                ///this allow for scroll view
                ScrollView {
                    LazyVGrid(columns: viewModel.determineColumns(for: dynamicTypeSize), content: {
                        ForEach(viewModel.checkedInProfiles){ profile in
                            FirstNameAvatarView(profile: profile)
                                .accessibilityElement(children: .ignore)
                                .accessibilityLabel(Text("\(profile.firstName) \(profile.lastName)"))
                        }
                        
                    })
                }
            }
            if viewModel.isLoading{LoadingView()}
        }
        
        .onAppear(){
            viewModel.getCheckedInProfiles()
            viewModel.getCheckedInStatus()
        }
    }
}
