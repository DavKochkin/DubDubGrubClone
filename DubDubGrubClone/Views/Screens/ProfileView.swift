//
//  ProfileView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 29.12.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var firstName   = ""
    @State private var lastName    = ""
    @State private var companyName = ""
    @State private var bio         = ""
    @State private var avatar      = PlaceholderImage.avatar
    @State private var isShowingPhotoPicker = false
    
    var body: some View {
        VStack {
            ZStack {
                NameBackgroundView()
                
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(image: avatar, size: 84)
                        EditImage()
                    }
                    .padding(.leading, 12)
                    .onTapGesture { isShowingPhotoPicker = true }
                    
                    VStack(spacing: 1) {
                        TextField.init("First Name", text: $firstName)
                            .profileNameStyle()
                        
                        TextField.init("Last Name", text: $lastName)
                            .profileNameStyle()
                        
                        TextField.init("Company Name", text: $companyName)
                    }
                    .padding(.trailing, 16)
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                CharactersRemainView(currentCount: bio.count)
                
                TextEditor(text: $bio)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, lineWidth: 1))
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button {
                
            } label: {
                DDGButton(title: "Create Profile")
            }
        }
        .navigationTitle("Profile")
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(image: $avatar)
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}

struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
    }
}

struct EditImage: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: 14, height: 14)
            .foregroundStyle(.white)
            .offset(y: 30)
    }
}

struct CharactersRemainView: View {
    
    var currentCount: Int
    
    var body: some View {
        Text("Bio: ")
            .font(.callout)
            .foregroundStyle(.secondary)
        +
        Text("\(100 - currentCount)")
            .font(.callout)
            .foregroundStyle(currentCount <= 100 ? .brandPrimary : Color(.systemPink))
        +
        Text(" Characters Remain")
            .font(.callout)
            .foregroundStyle(.secondary)
    }
}
