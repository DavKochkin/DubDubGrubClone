//
//  View+Ext.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 04.01.2024.
//

import SwiftUI

extension View {
    
    func profileNameStyle() -> some  View {
        self.modifier(ProfileNameText())
    }
}
