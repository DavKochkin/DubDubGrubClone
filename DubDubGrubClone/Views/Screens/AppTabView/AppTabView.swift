//
//  AppTabView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 29.12.2023.
//

import SwiftUI

struct AppTabView: View {
    
    @StateObject private var viewModel = AppTabViewModel()
    
    var body: some View {
        TabView {
            LocationMapView()
                .tabItem { Label("Map", systemImage: "map")  }
            
            LocationListView()
                .tabItem { Label("Location", systemImage: "building") }
            
            NavigationStack {
                ProfileView()
            }
            .tabItem { Label("Profile", systemImage: "person") }
        }
        .task {
            try? await CloudKitManager.shared.getUserRecord()
            viewModel.checkIfHasSeenOnboard()
        }
        .sheet(isPresented: $viewModel.isShowingOnboardView) { OnboardView() }
    }
}

#Preview {
    AppTabView()
}

