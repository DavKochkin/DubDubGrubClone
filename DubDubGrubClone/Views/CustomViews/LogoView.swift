//
//  LogoView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 15.01.2024.
//

import SwiftUI

struct LogoView: View {
    
    var frameWidth: CGFloat
    
    var body: some View {
        Image(decorative: "ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(width: frameWidth)
    }
}

#Preview {
    LogoView(frameWidth: 250)
}
