//
//  LocationMapView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 29.12.2023.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 56.968,
            longitude: 23.77038),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01))
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
            
            VStack {
                Image("ddg-map-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 70)
                    .shadow(radius: 10)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LocationMapView()
}
