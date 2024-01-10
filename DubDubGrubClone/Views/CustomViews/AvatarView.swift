//
//  AvatarView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 04.01.2024.
//

import SwiftUI

struct AvatarView: View {
    
    var size: CGFloat
    
    var body: some View {
        Image("default-avatar")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}


#Preview {
    AvatarView(size: 90)
}
