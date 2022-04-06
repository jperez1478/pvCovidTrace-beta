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

    
}
