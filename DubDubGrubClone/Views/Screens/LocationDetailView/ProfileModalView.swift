//
//  ProfileModalView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 26.01.2024.
//

import SwiftUI

struct ProfileModalView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 60)
                Text("David Kochkin")
                    .bold()
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                Text("Test Company")
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundStyle(.secondary)

                Text("This is my simple bio. Lets keep typing to see how long we can make it.How does the padding is looking.")
                    .lineLimit(3)
                    .padding()
            }
            .frame(width: 300, height: 230, alignment: .center)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                Button {
                    //dismiss
                } label: {
                    XDismissButton()
                }, alignment: .topTrailing )
            
            Image(uiImage: PlaceholderImage.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6 )
                .offset(y: -120)
        }
    }
}

#Preview {
    ProfileModalView()
}
