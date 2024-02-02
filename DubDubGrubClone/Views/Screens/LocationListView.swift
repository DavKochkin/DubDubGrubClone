//
//  LocationListView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 29.12.2023.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        NavigationView {
            List {
                ForEach(locationManager.locations) { location in
                    NavigationLink(destination: LocationDetailView(viewModel: LocationDetailViewModel(location: location))) {
                        LocationCell(location: location)
                    }
                }
            }
            .navigationTitle("Grub Spots")
            .onAppear {
                CloudKitManager.shared.getCheckInProfilesDictionary { result in
                    switch result {
                    case .success(let checkedInProfile):
                        print(checkedInProfile)
                    case .failure(_):
                        print("Error getting back dictionary")
                    }
                }
            }
        }
    }
}

#Preview {
    LocationListView()
}
