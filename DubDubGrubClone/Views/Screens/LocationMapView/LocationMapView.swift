//
//  LocationMapView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 29.12.2023.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationMapViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: locationManager.locations) { location in
                MapAnnotation(coordinate: location.location.coordinate,
                              anchorPoint: CGPoint(x: 0.5, y: 0.75)) {
                    DDGAnnotation(location: location)
                        .onTapGesture {
                            locationManager.selectedLocation = location
                        }
                }
            }
                .accentColor(.grubRed)
                .ignoresSafeArea()
            
            VStack {
                LogoView(frameWidth: 125)
                    .shadow(radius: 10)
                
                Spacer()
            }
        }
//        .sheet(isPresented: $viewModel.isShowingOnboardView, onDismiss: viewModel.checkIfLocationServicesIsEnabled) {
//            OnboardView(isShowingOnboardView: $viewModel.isShowingOnboardView)
//        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        })
        .onAppear {
//            viewModel.runStartupChecks()
            
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
            }
        }
    }
}

#Preview {
    LocationMapView()
}


