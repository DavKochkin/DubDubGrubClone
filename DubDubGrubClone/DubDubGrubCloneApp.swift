//
//  DubDubGrubCloneApp.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 29.12.2023.
//

import SwiftUI

@main
struct DubDubGrubCloneApp: App {
    
    let locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            AppTabView().environmentObject(locationManager)
        }
    }
}
