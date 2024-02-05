//
//  LocationMapViewModel.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 09.01.2024.
//

import MapKit
import CloudKit

final class LocationMapViewModel: ObservableObject {
    
    @Published var checkedInProfiles: [CKRecord.ID: Int] = [:]
    @Published var isShowingDetailView = false
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.331516,
            longitude: -121.891054),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01))
    
    func getLocations(for locationManager: LocationManager) {
        CloudKitManager.shared.getLocations { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let locations):
                    locationManager.locations = locations
                case .failure(_):
                    self.alertItem = AlertContext.unableToGetLocations
                }
            }
        }
    }
    
    func getCheckedInCounts() {
        CloudKitManager.shared.getCheckInProfilesCount { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let checkedInProfiles):
                    self.checkedInProfiles = checkedInProfiles
                case .failure(_):
                    // show alert
                    break
                }
            }
        }
    }
}

