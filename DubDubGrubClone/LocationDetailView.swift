//
//  LocationDetailView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 01.01.2024.
//

import SwiftUI

struct LocationDetailView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("default-banner-asset")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 120)
                
                HStack {
                    Label("123 Main Street", systemImage: "mappin.and.ellipse")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        
                    Spacer()
                }
                .padding(.horizontal)
                
                Text("This is a test description. This is a test description. This is a test description.")
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Location Name")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LocationDetailView()
}
