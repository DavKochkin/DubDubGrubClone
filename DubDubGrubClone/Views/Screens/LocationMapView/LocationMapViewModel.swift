//
//  LocationMapViewModel.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 09.01.2024.
//
import SwiftUI
import MapKit
import CloudKit

extension LocationMapView {
    
    final class LocationMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
        
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
        
        
        let deviceLocationManager = CLLocationManager()
        
        override init() {
            super.init()
            deviceLocationManager.delegate = self
        }
        
        
        func requestAllowOnceLocationPermission() {
            deviceLocationManager.requestLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let currentLocation = locations.last else { return }
            
            withAnimation {
                region = MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                                                                       longitudeDelta: 0.01))
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Did Fail With Error.")
        }
        
        
        @MainActor
        func getLocations(for locationManager: LocationManager) {
            
            Task {
                do {
                    locationManager.locations = try await CloudKitManager.shared.getLocations()
                } catch {
                    alertItem = AlertContext.unableToGetLocations
                }
            }
            
            
//            CloudKitManager.shared.getLocations { [weak self] result in
//                DispatchQueue.main.async {
//                    guard let self = self else { return }
//                    
//                    switch result {
//                    case .success(let locations):
//                        locationManager.locations = locations
//                    case .failure(_):
//                        self.alertItem = AlertContext.unableToGetLocations
//                    }
//                }
//            }
        }
        
        
        @MainActor
        func getCheckedInCounts() {
            Task {
                do {
                    checkedInProfiles = try await CloudKitManager.shared.getCheckInProfilesCount()
                } catch {
                    alertItem = AlertContext.checkedInCount
                }
            }
        }
    }
}
