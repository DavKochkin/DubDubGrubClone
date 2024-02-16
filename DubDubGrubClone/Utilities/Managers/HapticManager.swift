//
//  HapticManager.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 16.02.2024.
//

import UIKit

struct HapticManager {
    
    static func playSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}
