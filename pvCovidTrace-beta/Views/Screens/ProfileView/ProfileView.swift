//
//  ProfileView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//


import SwiftUI
import CloudKit

struct ProfileView: View {
    @StateObject private var viewModel =  ProfileViewModel()
    
    var body: some View {
        ZStack {
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
                            TextField("First Name", text: $viewModel.firstName).profileNameStyle()
                            TextField("Last Name", text: $viewModel.lastName)
                                .font(.system(size: 32, weight: .bold))
                                .lineLimit(1)
                                .minimumScaleFactor(0.75)
                        }
                        .padding(.trailing, 16)
                        
                    }
                    .padding()
                    
                }
                
                VStack(alignment: .leading, spacing: 8){
                    HStack{
                        CharactersRemainingView(currentCount:  viewModel.covidStatus.count)
                        Spacer()
                        
                        
                        Button {
                            
                        } label: {
                            Label("Check Out", systemImage: "mappin.and.ellipse")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(10)
                                .frame(height: 28)
                                .background(Color.brandPrimary)
                                .cornerRadius(8)
                            
                        }
                    }
                    TextEditor(text: $viewModel.covidStatus)
                        .frame(width: 100, height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary,  lineWidth: 1))
                        
            }
            
            .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    viewModel.profileContext == .create ? viewModel.createProfile() : viewModel.updateProfile()
                } label: {
                    submitButton(title:  viewModel.profileContext ==  .create ? "Submit Status" : "Update Covid Status")
                        
                }
                
                .padding(.bottom)
            }
            
            if viewModel.isLoading  { LoadingView() }
                
            
        }
     
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .onAppear { viewModel.getProfile() }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dissmissButton)
            
        })
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
