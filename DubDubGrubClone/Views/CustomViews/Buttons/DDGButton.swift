//
//  DDGButton.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 04.01.2024.
//

import SwiftUI

struct DDGButton: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .bold()
            .frame(width: 280, height: 44)
            .background(.brandPrimary)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    DDGButton(title: "Create Profile")
}
