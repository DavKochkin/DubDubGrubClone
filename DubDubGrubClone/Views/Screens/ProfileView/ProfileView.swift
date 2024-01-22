//
//  ProfileView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 29.12.2023.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                NameBackgroundView()
                
                HStack(spacing: 16) {
                    ZStack {
                        AvatarView(image: viewModel.avatar, size: 84)
                        EditImage()
                    }
                    .padding(.leading, 12)
                    .onTapGesture { viewModel.isShowingPhotoPicker = true }
                    
                    VStack(spacing: 1) {
                        TextField.init("First Name", text: $viewModel.firstName) .profileNameStyle()
                        TextField.init("Last Name", text: $viewModel.lastName).profileNameStyle()
                        TextField.init("Company Name", text: $viewModel.companyName)
                    }
                    .padding(.trailing, 16)
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                CharactersRemainView(currentCount: viewModel.bio.count)
                
                TextEditor(text: $viewModel.bio)
                    .frame(height: 100)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, lineWidth: 1))
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button {
                viewModel.createProfile()
            } label: {
                DDGButton(title: "Create Profile")
            }
            .padding(.bottom)
        }
        .navigationTitle("Profile")
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .onAppear { viewModel.getProfile() }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        })
        .sheet(isPresented: $viewModel.isShowingPhotoPicker) {
            PhotoPicker(image: $viewModel.avatar)
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
