//
//  ProfileView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//


import SwiftUI

struct ProfileView: View {
    
    @State private var firstName    = ""
    @State private var lastName     = ""
  
    @State private var covidStatus         = ""
        
    
    var body: some View {
        VStack {
            ZStack {
                NameBackgroundView()
                
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(size: 84)
                        EditImage()
                    }
                    .padding(.leading, 12)
                    
                    VStack(spacing: 1) {
                        TextField("First Name", text: $firstName)
                            .profileNameStyle()
                        
                        TextField("Last Name", text: $lastName)
                            .font(.system(size: 32, weight: .bold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        
                        
                    }
                    .padding(.trailing, 16)
                    
                }
                .padding()
                
            }
            
            VStack(alignment: .leading, spacing: 8){
                CharactersRemainingView(currentCount:  covidStatus.count)
                TextEditor(text: $covidStatus)
                    .frame(width: 100, height: 50)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary,  lineWidth: 1))
                    
        }
        
        
            
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button {
            } label: {
               submitButton(title: "Submit Status")
                    
            }
        }
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}



struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

struct EditImage:View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: 14, height: 14)
            .foregroundColor(.white)
            .offset(y: 30)
    }
}

struct CharactersRemainingView: View {
    var currentCount: Int
    var body: some View{
        Text("\(20  -  currentCount)")
            .bold()
            .font(.callout)
            .foregroundColor(currentCount  <= 100 ? .brandPrimary : Color(.systemPink))
            
        +
        
        Text(" Characthers Remain")
            .font(.callout)
            .foregroundColor(.secondary)

    }
}