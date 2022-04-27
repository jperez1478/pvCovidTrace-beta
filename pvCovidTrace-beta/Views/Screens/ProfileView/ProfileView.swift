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
    var placeholder = "Select Status"
    
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
                        .accessibilityElement(children: .ignore)
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
                        /*CharactersRemainingView(currentCount:  viewModel.covidStatus.count)
                            .accessibilityAddTraits(.isHeader)
                         */
                        Text("Select Covid Status to Submit")
                            .bold()
                        Spacer()
                        
                        //Only show the check out button if the user is checkin somewhere
                        if viewModel.isCheckedIn{
                            Button {
                                viewModel.checkOut()
                            } label: {
                                Label("Check Out", systemImage: "mappin.and.ellipse")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .frame(height: 28)
                                    .background(Color.brandPrimary)
                                    .cornerRadius(8)
                                
                            }
                            .accessibilityLabel(Text("Check out of current location"))
                        }
                       
                     
                    }/*
                    TextEditor(text: $viewModel.covidStatus)
                        .frame(width: 100, height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.secondary,  lineWidth: 1))
                        .accessibilityLabel(Text("Covid Status, \(viewModel.covidStatus)"))
                        .accessibilityHint(Text("This TextField has a 20 charcter maximum."))
                      */
                    //Dropdown()
                    Menu {
                        ForEach(viewModel.dropDownList, id: \.self){ status in
                            Button(status){
                                viewModel.covidStatus = status
                            }
                        }
                    } label: {
                        VStack(spacing: 5){
                            HStack{
                                Text(viewModel.covidStatus.isEmpty ? placeholder : viewModel.covidStatus)
                                    .foregroundColor(viewModel.covidStatus.isEmpty ? .gray : .black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(Color.brandPrimary)
                                    .font(Font.system(size: 20, weight: .bold))
                            }
                            .padding(.horizontal)
                            Rectangle()
                                .fill(Color.brandPrimary)
                                .frame(height: 2)
                        }
                    }
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
        .navigationBarTitleDisplayMode(DeviceTypes.isiPhone8Standard ? .inline : .automatic)
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .onAppear {
            viewModel.getProfile()
            viewModel.getCheckedInStatus()
        }
        .alert(item: $viewModel.alertItem, content: { $0.alert})
    }


}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}



fileprivate struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

fileprivate struct EditImage: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: 14, height: 14)
            .foregroundColor(.white)
            .offset(y: 30)
    }
}

fileprivate struct CharactersRemainingView: View {
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

/*
struct Dropdown: View {
    @State var value = ""
    var placeholder = "Select Status"
    var dropDownList = ["Positive", "Negative"]
    var body: some View{
        Menu {
            ForEach(dropDownList, id: \.self){ client in
                Button(client){
                    self.value = client
                }
            }
        } label: {
            VStack(spacing: 5){
                HStack{
                    Text(value.isEmpty ? placeholder : value)
                        .foregroundColor(value.isEmpty ? .gray : .black)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.brandPrimary)
                        .font(Font.system(size: 20, weight: .bold))
                }
                .padding(.horizontal)
                Rectangle()
                    .fill(Color.brandPrimary)
                    .frame(height: 2)
            }
        }
        
    }
    
    
}
 */
