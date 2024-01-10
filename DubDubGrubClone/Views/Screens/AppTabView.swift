//
//  AppTabView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 29.12.2023.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            LocationMapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            LocationListView()
                .tabItem {
                    Label("Location", systemImage: "building")
                }
            
            NavigationView {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        }
        .accentColor(.brandPrimary)
    }
}

#Preview {
    AppTabView()
}

