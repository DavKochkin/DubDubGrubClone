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
    static let unableToGetLocations = Alert(title: Text("Location Error"),
                                            message: Text("Unable to retrieve locations at this time.\nPlease try again."),
                                            dismissButton: .default(Text("")))
}


