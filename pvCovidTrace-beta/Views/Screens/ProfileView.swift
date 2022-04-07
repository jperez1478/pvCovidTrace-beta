//
//  ProfileView.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/29/22.
//


import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @State private var firstName    = ""
    @State private var lastName     = ""
  
    @State private var covidStatus         = ""
    @State private var avatar  =  PlaceholderImage.avatar
    
    @State private var alertItem: AlertItem?
        
    
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
                createProfile()
            } label: {
               submitButton(title: "Submit Status")
                    
            }
            
            .padding(.bottom)
        }
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        
        .alert(item: $alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dissmissButton)
            
        })
    }

func isValidProfile() -> Bool {
    guard   !firstName.isEmpty,
                !lastName.isEmpty,
                !covidStatus.isEmpty,
            covidStatus.count < 20 else { return false }
                
       return true
    }
    
    func createProfile() {
        guard isValidProfile()  else {
            alertItem = AlertContext.invalidProfile
            return
        }
        
        // Create our CKRecord from the profileView
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[PVProfile.kFirstName] = firstName
        profileRecord[PVProfile.kLastName] =  lastName
        profileRecord[PVProfile.kCovidStatus] = covidStatus
        // Get our UserRecordID from the Container
        CKContainer.default().fetchUserRecordID { recordID, error  in
            guard  let recordID =  recordID, error == nil else {
                print(error!.localizedDescription)
                return
            }
            //Get UserRecord from the Public Database
            CKContainer.default().publicCloudDatabase.fetch(withRecordID:  recordID) { userRecord, error in
                guard let userRecord = userRecord, error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                // Create refrence on UserRecord to the PVProfile we created
                userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
                
                // Create a CKOperarion to save  User and Profile Records
                //ARRAY of users to create
                let operation = CKModifyRecordsOperation(recordsToSave: [userRecord, profileRecord])
                //modifier for record
                operation.modifyRecordsCompletionBlock = { savedRecords, _, error in
                    guard let savedRecords = savedRecords, error == nil else {
                        print(error!.localizedDescription)
                        return
                        
                }
                    
                    //if records save print to test
                print(savedRecords)
            }
                
                CKContainer.default().publicCloudDatabase.add(operation) //similar to url session like network call
        }
            
        }
        
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
