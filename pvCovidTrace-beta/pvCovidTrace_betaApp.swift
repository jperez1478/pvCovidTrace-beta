//
//  pvCovidTrace_betaApp.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/27/22.
//

import SwiftUI

@main
struct pvCovidTrace_betaApp: App {
    let locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            AppTabView().environmentObject(locationManager)
        }
    }
}
