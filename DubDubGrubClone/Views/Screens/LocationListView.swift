//
//  LocationListView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 29.12.2023.
//

import SwiftUI

struct LocationListView: View {
    
    @State private var locations: [DDGLocation] = [DDGLocation(record: MockData.location)]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locations) { location in
                    NavigationLink(destination: LocationDetailView(location: location)) {
                        LocationCell(location: location)
                    }
                }
            }
            .navigationTitle("Grub Spots")
        }
    }
}

#Preview {
    LocationListView()
}
