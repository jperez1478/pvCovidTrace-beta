//
//  AlertItem.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import  SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dissmissButton: Alert.Button
    
}


struct AlertContext {
    
    //MARK: - MapView Error
    
    static let unableToGetLocations = AlertItem(title:Text("Locations Error"),
                                                message: Text("Unable to retrive locations at this time.\nPlease try again"),
                                                dissmissButton:  .default(Text("Ok")))
    
    static let locationRestricted = AlertItem(title:Text("Locations Restricted"),
                                                message: Text("Your location is restricted. This may be due to parental controls"),
                                                dissmissButton:  .default(Text("Ok")))
    
    static let locationDenied = AlertItem(title:Text(" Location Denied"),
                                                message: Text("PVCovidTrace does not have permission to acces your location.To change that go to your phone's settings > PVCovidTrace >  Location"),
                                                dissmissButton:  .default(Text("Ok")))
    
    static let locationDisabled = AlertItem(title:Text(" Location Disabled"),
                                                message: Text("Your phone's location services are disabled. To change that go to your phone's settins > Privacy > Location Services"),
                                                dissmissButton:  .default(Text("Ok")))
 
    //MARK: - ProfileViewErrors
    static let invalidProfile = AlertItem(title:Text(" Invalid Profile"),
                                                message: Text("All fields are required as well as covidStatus. Covid status wont be shown to other students only Visible to you"),
                                                dissmissButton:  .default(Text("Ok")))

    static let noUserRecord   = AlertItem(title:Text(" No User Record "),
                                                message: Text("You musty log to iCloud on your phone in order to utilize PVCovidTrace Profile. Please  log in on  your phone's settings  screen."),
                                                dissmissButton:  .default(Text("Ok")))

    
    static let createProfileSuccess  = AlertItem(title:Text(" Profile Status Created Succesfully ✅ "),
                                                message: Text("Your profile has succesfully been created"),
                                                dissmissButton:  .default(Text("Ok")))
    
    
    static let createProfileFailure  = AlertItem(title:Text(" Failure to Create Profile "),
                                                message: Text("We are unable to create your profile at this time.\n Please try again later or contact customer support if this persists."),
                                                dissmissButton:  .default(Text("Ok")))


    static let unableToGetProfile  = AlertItem(title:Text(" Unable to Retrive Profile  "),
                                                message: Text("We are unable to retrieve your profile at this time.\n Please check your internet connection and try again later "),
                                                dissmissButton:  .default(Text("Ok")))
    
    
    static let updateProfileSuccess  = AlertItem(title:Text("Profile Update Success! "),
                                                message: Text("Your PVCovidTrace Profile was updated succesfully "),
                                                dissmissButton:  .default(Text("Sweet!")))

    static let updateProfileFailure  = AlertItem(title:Text("Profile Update failed "),
                                                message: Text("We are unabl,e to update your profile atr this time \n. Please try again later."),
                                                dissmissButton:  .default(Text("Ok")))
    static let unableToGetCheckInStatus  = AlertItem(title:Text("Server error"),
                                                message: Text("Unable to retrieve checked in status of the current user.\nPlease try again."),
                                                dissmissButton:  .default(Text("Ok")))
    static let unableToCheckInorOut  = AlertItem(title:Text("Server error"),
                                                message: Text("We are unable to check in/out at this time. \nPlease try again."),
                                                dissmissButton:  .default(Text("Ok")))
    static let unableToGetCheckedInProfiles  = AlertItem(title:Text("Server error"),
                                                message: Text("We are unable to get users checked into this location at this time. \nPlease try again."),
                                                dissmissButton:  .default(Text("Ok")))
}
