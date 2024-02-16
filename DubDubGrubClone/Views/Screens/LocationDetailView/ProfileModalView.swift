//
//  ProfileModalView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 26.01.2024.
//

import SwiftUI

struct ProfileModalView: View {
    
    @Binding var isShowingProfileModal: Bool
    var profile: DDGProfile
    
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 60)
                Text(profile.firstName + " " + profile.lastName)
                    .bold()
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .padding(.horizontal)
                
                Text(profile.companyName)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
                    .accessibilityLabel(Text("Work's at \(profile.companyName)"))

                Text(profile.bio)
                    .lineLimit(3)
                    .padding()
                    .accessibilityLabel(Text("Bio, \(profile.bio)"))
            }
            .frame(width: 300, height: 230, alignment: .center)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                Button {
                    withAnimation { isShowingProfileModal = false }
                } label: {
                    XDismissButton()
                }, alignment: .topTrailing )
            
            Image(uiImage: profile.createAvatarImage())
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6 )
                .offset(y: -120)
                .accessibilityHidden(true)
        }
        .transition(.opacity.combined(with: .slide))
        .animation(.easeOut)
        .zIndex(2)
    }
}

#Preview {
    ProfileModalView(isShowingProfileModal: .constant(true), 
                     profile: DDGProfile(record: MockData.profile))
}
