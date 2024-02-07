//
//  LocationListViewModel.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 03.02.2024.
//

import CloudKit

final class LocationListViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID: [DDGProfile]] = [:]
    
    func getCheckInProfilesDictionary() {
        CloudKitManager.shared.getCheckInProfilesDictionary { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let checkedInProfile):
                    self.checkedInProfiles = checkedInProfile
                case .failure(_):
                    print("Error getting back dictionary")
                }
            }
        }
    }
}
