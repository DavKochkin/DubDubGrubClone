//
//  DDGAnnotation.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 04.02.2024.
//

import SwiftUI

struct DDGAnnotation: View {
    var body: some View {
        VStack {
            ZStack {
                MapBalloon()
                    .frame(width: 100, height: 70)
                    .foregroundStyle(.brandPrimary)
                
                Image(uiImage: PlaceholderImage.square)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .offset(y: -11)
            }
            
            Text("Test Location")
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    DDGAnnotation()
}
