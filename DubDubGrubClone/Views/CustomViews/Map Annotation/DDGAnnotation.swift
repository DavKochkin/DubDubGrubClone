//
//  DDGAnnotation.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 04.02.2024.
//

import SwiftUI

struct DDGAnnotation: View {
    
    var location: DDGLocation
    var number: Int
    
    var body: some View {
        VStack {
            ZStack {
                MapBalloon()
                    .fill(Color.brandPrimary.gradient)
                    .frame(width: 100, height: 70)
//                    .foregroundStyle(.brandPrimary)
                
                Image(uiImage: location.createSquareImage())
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                    .offset(y: -11)
                
                if number > 0 {
                    Text("\(min(number, 99))")
                        .font(.system(size: 11, weight: .bold))
                        .frame(width: 26, height: 18)
                        .background(Color.grubRed)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .offset(x: 20, y: -28)
                }
            }
            
            Text(location.name)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .accessibilityLabel(Text("Map Pin \(location.name) \(number) checked in."))
    }
}

#Preview {
    DDGAnnotation(location: DDGLocation(record: MockData.location), number: 44)
}
