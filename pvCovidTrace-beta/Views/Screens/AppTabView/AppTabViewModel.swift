//
//  AppTabViewModel.swift
//  pvCovidTrace-beta
//
//  Created by Jamal  Henry on 4/12/22.
//

import CoreLocation

final class AppTabViewModel: NSObject, ObservableObject{
    @Published var isShowingOnBoardView = true
    @Published var alertItem: AlertItem?
    
    var deviceLocationManager: CLLocationManager?
    let kHasSeenOnBoardView = "hasSeenOnBoardView"
    
    var hasSeenOnBoardView: Bool{
        return UserDefaults.standard.bool(forKey: kHasSeenOnBoardView)
    }
    
    func runStartUpChecks() {
        if !hasSeenOnBoardView{
            isShowingOnBoardView = true
            UserDefaults.standard.set(true, forKey: kHasSeenOnBoardView)
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
    
}

extension AppTabViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

