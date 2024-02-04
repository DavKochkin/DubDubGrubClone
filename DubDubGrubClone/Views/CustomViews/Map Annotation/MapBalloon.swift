//
//  MapBalloon.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 04.02.2024.
//

import SwiftUI

struct MapBalloon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        return path
    }
}

#Preview {
    MapBalloon()
}
