//
//  LocationMapViewModel.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 09.01.2024.
//

import MapKit

final class LocationMapViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.331516,
            longitude: -121.891054),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01))
    
    var deviceLocationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            deviceLocationManager = CLLocationManager()
        }
    }
    
    func checkLocationAuthorization() {
        guard let deviceLocationManager = deviceLocationManager else { return }
        
        switch deviceLocationManager.authorizationStatus {
        case .notDetermined:
            deviceLocationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            // show alert
//        case .denied:
//            // show alert
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func getLocations(for locationManager: LocationManager) {
        CloudKitManager.getLocations { [weak self] result in
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
}
