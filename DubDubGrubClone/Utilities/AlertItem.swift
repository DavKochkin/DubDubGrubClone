//
//  AlertItem.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 09.01.2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    // MARK: - MapView Errors
    static let unableToGetLocations = AlertItem(title: Text("Location Error"),
                                            message: Text("Unable to retrieve locations at this time.\nPlease try again."),
                                            dismissButton: .default(Text("")))
    
    static let locationRestricted   = AlertItem(title: Text("Location Restricted"),
                                            message: Text("Your location is restriced. This may be due to parental controls"),
                                            dismissButton: .default(Text("")))
    
    static let locationDenied       = AlertItem(title: Text("Location Denied"),
                                            message: Text("Dub Dub Grub does not have permission to access your location. To change that go to your phone's Settings > Dub Dub Grub > Location"),
                                            dismissButton: .default(Text("")))
    
    static let locationDisabled     = AlertItem(title: Text("Location Disabled"),
                                            message: Text("Your phone's location services are disabled. To change that go to your phone's Settings > Privacy > Location Services"),
                                            dismissButton: .default(Text("")))
}


