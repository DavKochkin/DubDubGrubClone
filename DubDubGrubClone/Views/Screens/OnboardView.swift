//
//  OnboardView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 14.01.2024.
//

import SwiftUI

struct OnboardView: View {
    
    @Binding var isShowingOnboardView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    isShowingOnboardView = false
                } label: {
                   XDismissButton()
                }
                .padding()
            }
            
            Spacer()
            
            LogoView(frameWidth: 250)
                .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 32) {
                OnboardInfoView(imageName: "building.2.crop.circle",
                                titleName: "Restaurant Locations",
                                descriptionName: "Find places to dine around the convention center.")
                
                OnboardInfoView(imageName: "checkmark.circle",
                                titleName: "Check In",
                                descriptionName: "Let the other iOS Devs know where you are")
                
                OnboardInfoView(imageName: "person.2.circle",
                                titleName: "Find Friends",
                                descriptionName: "See where other iOS Devs are and join the party.")
            }
            .padding(.horizontal, 40)
            
            Spacer()
        }
    }
}

#Preview {
    OnboardView(isShowingOnboardView: .constant(true))
}

struct OnboardInfoView: View {
    
    var imageName: String
    var titleName: String
    var descriptionName: String
    
    var body: some View {
        HStack(spacing: 26) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.brandPrimary)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(titleName).bold()
                Text(descriptionName)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}
