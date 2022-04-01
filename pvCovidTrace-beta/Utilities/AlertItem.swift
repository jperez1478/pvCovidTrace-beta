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
}
