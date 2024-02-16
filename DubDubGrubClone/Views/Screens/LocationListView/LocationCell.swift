//
//  LocationCell.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 04.01.2024.
//

import SwiftUI

struct LocationCell: View {
    
    var location: DDGLocation
    var profiles: [DDGProfile]
    
    var body: some View {
        HStack{
            Image(uiImage: location.createSquareImage())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                if profiles.isEmpty {
                    Text("Nobody's Checked In")
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                        .padding(.top, 1)
                } else {
                    HStack {
                        ForEach(profiles.indices, id: \.self) { index in
                            if index <= 3 || (index == 4 && profiles.count == 5) {
                                AvatarView(image: profiles[index].createAvatarImage(), size: 35)
                            } else if index == 4 {
                                AdditionalProfilesView(number: min(profiles.count - 4, 99))
                            }
                        }
                    }
                }

            }
            .padding(.leading)
        }
    }
}

#Preview {
    LocationCell(location: DDGLocation(record: MockData.location), profiles: [])
}

fileprivate struct AdditionalProfilesView: View {
    
    var number: Int
    
    var body: some View {
        Text("+\(number)")
            .font(.system(size: 14, weight: .semibold))
            .frame(width: 35, height: 35)
            .foregroundStyle(Color.brandPrimary)
            .clipShape(Circle())
    }
}
