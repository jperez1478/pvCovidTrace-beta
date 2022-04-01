//
//  OnboardingView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 4/1/22.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            LogoView(frameWidth: 250)
            VStack(alignment: .leading) {
                OnboardingInfoView(imageName: "building.2.crop.circle", title: "Campus Locations", description: "Campus Locations to check in")
                OnboardingInfoView(imageName: "checkmark.circle", title: "Check In ", description: "Check in where you had been prior your status ")
                OnboardingInfoView(imageName: "person.2.circle", title: "Keep PVComunity Safe", description: "locations check in help students be aware")
                OnboardingInfoView(imageName: "building.2.crop.circle", title: "Campus Locations", description: "Check in where you had been prior your status ")
            }
            
            .padding()
                        
                }
            }


        }
    

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct OnboardingInfoView: View {
    var imageName: String
    var title: String
    var  description: String
    
    var body: some View {
        HStack(spacing: 26) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.brandPrimary)
            
            VStack(alignment: .leading) {
                Text(title).bold()
                
                Text(description)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
            }
        }
    }
}
