//
//  AppTabViewModel.swift
//  pvCovidTrace-beta
//
//  Created by Jamal  Henry on 4/12/22.
//

import CoreLocation
import SwiftUI

extension AppTabView{
    final class AppTabViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
        @Published var isShowingOnBoardView = true
        @Published var alertItem: AlertItem?
        @AppStorage("hasSeenOnBoardView") var hasSeenOnboardView = false {
            didSet{isShowingOnBoardView = hasSeenOnboardView}
        }
        
        var deviceLocationManager: CLLocationManager?
        let kHasSeenOnBoardView = "hasSeenOnBoardView"
        
        
        func runStartUpChecks() {
            if !hasSeenOnboardView{
                hasSeenOnboardView = true
            } else{
                checkIfLocationServicesIsEnabled()
            }
        }
        
        func checkIfLocationServicesIsEnabled() {
            if CLLocationManager.locationServicesEnabled() {
                deviceLocationManager = CLLocationManager()
                deviceLocationManager!.delegate = self
            } else {
                alertItem = AlertContext.locationDisabled
            }
        }
        
        private func checkLocationAuthorization() {
            
            guard let deviceLocationManager = deviceLocationManager else { return }
            
            switch deviceLocationManager.authorizationStatus {
                case .notDetermined:
                    deviceLocationManager.requestWhenInUseAuthorization()
                case .restricted:
                    alertItem = AlertContext.locationRestricted
                case .denied:
                    alertItem = AlertContext.locationDenied
                case .authorizedAlways, .authorizedWhenInUse:
                    break
                @unknown default:
                    break
            }
        }
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }
    }
}
