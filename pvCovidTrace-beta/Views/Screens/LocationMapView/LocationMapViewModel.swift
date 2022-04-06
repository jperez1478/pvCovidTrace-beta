//
//  LocationMapViewModel.swift
//  pvCovidTrace-beta
//
//  Created by Jessica Perez on 3/30/22.
//

import Foundation
import MapKit

final class LocationMapViewModel: NSObject, ObservableObject {
    
    @Published var isShowingOnBoardView = true
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.09233,
                                                                                longitude:     -95.99029),
                                                                                 span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
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
    
    func getLocations(for locationManager: LocationManager) {
        CloudKitManager.getLocations { [self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let locations):
                        locationManager.locations = locations
                    case .failure(_):
                        alertItem = AlertContext.unableToGetLocations
                }
            }
        }
    }
}

extension LocationMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}

