//
//  LocationListViewModel.swift
//  pvCovidTrace-beta
//
//  Created by Jamal  Henry on 4/11/22.
//

import Foundation
import CloudKit
import SwiftUI

extension LocationListView {
    
    final class LocationListViewModel: ObservableObject {
        
        @Published var checkedInProfiles: [CKRecord.ID: [PVProfile]] = [:]
        @Published var alertItem : AlertItem?
        
        func getCheckedInProfileDictionary(){
            CloudKitManager.shared.getCheckedInProfilesDictionary{ result in
                DispatchQueue.main.async { [self] in
                    switch result{
                    case .success(let checkedInProfiles):
                        self.checkedInProfiles = checkedInProfiles
                    case .failure(_):
                        print("Error getting back dictionary")
                        alertItem = AlertContext.unableToGetAllCheckedInProfiles
                        
                    }
                }
            }
        }
        
        func createVoiceOverSummary(for location: PVLocations) -> String {
            let count = checkedInProfiles[location.id, default: []].count
            let personPlurality = count == 1 ? "person" : "people"
            
            return "\(location.name) \(count) \(personPlurality) checked in"
        }
        
        @ViewBuilder func createLocationDetailView(for location: PVLocations, in dynamicTypeSize: DynamicTypeSize) -> some View {
            if dynamicTypeSize >= .accessibility3 {
                LocationDetailView(viewModel: LocationDetailViewModel(location: location)).embedInScrollView()
            } else {
                LocationDetailView(viewModel:LocationDetailViewModel(location: location))
            }
        }
    }

    
}
