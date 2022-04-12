//
//  LocationDetailView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//

import SwiftUI

struct LocationDetailView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    @Environment(\.sizeCategory) var sizeCategory
   
    
    var body: some View {
        VStack(spacing: 16) {
            BannerImageView(image: viewModel.location.createBannerImage())
            
            HStack {
                AdressView(adressString: viewModel.location.adress)
                
                Spacer()
            }
            .padding(.horizontal)
            
            
            //this can be fixed
            DescriptionView(text: viewModel.location.description)
            
            
            ZStack{
                Capsule()
                    .frame(height: 80)
                    .foregroundColor(Color(.secondarySystemBackground))
                
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
                                .accessibilityLabel(Text("Go to Website"))
                        }
                    })
                    
                        Button {
                            viewModel.updateCheckInStatus(to: viewModel.isCheckedIn ? .checkedOut: .checkedIn)
                            playHaptic()
                        } label: {
                            LocationActionButton(color: viewModel.isCheckedIn ? .red : .brandPrimary, imageName: viewModel.isCheckedIn ? "person.fill.checkmark" : "person.fill.checkmark")
                                .accessibilityLabel(Text(viewModel.isCheckedIn ? "Check out of location" : "Check into location"))
                        }
                   

                }
                
            }
            .padding(.horizontal)
            Text("Whos here?")
                .bold()
                .font(.title2)
                .accessibility(addTraits: .isHeader)
                .accessibilityLabel(Text("Who's Here? \(viewModel.checkedInProfiles.count) checked in"))
                .accessibilityHint(Text("Bottom section is scrollable"))
            ZStack{
                if viewModel.checkedInProfiles.isEmpty{
                    Text("Nobody's Here")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .padding(.top, 30)
                }else {
                    ///this allow for scroll view
                    ScrollView {
                        LazyVGrid(columns: viewModel.determineColumns(for: sizeCategory), content: {
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
    
    @Environment(\.sizeCategory) var sizeCategory
    var profile: PVProfile
    
    var body: some View{
        VStack{
            AvatarView(size: sizeCategory >= .accessibilityMedium ? 100 : 64)
            
            Text(profile.firstName)
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
            .accessibilityHidden(true)
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
            .minimumScaleFactor(0.75)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
    }
}
