//
//  LocationListViewModel.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 03.02.2024.
//

import CloudKit

extension LocationListView {
    
    final class LocationListViewModel: ObservableObject {
        @Published var checkedInProfiles: [CKRecord.ID: [DDGProfile]] = [:]
        @Published var alertItem: AlertItem?
        
        func getCheckInProfilesDictionary() {
            CloudKitManager.shared.getCheckInProfilesDictionary { result in
                DispatchQueue.main.async { [self] in
                    switch result {
                    case .success(let checkedInProfile):
                        self.checkedInProfiles = checkedInProfile
                    case .failure(_):
                        alertItem = AlertContext.unableToGetAllProfiles
                    }
                }
            }
        }
        
        
        func createVoiceOverSummary(for location: DDGLocation) -> String {
            let  count = checkedInProfiles[location.id, default: []].count
            let personPlurality = count == 1 ? "person" : "people"
            
            return "\(location.name) \(count) \(personPlurality) checked in."
        }
    }
}
