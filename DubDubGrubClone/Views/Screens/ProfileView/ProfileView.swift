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
        ZStack {
            VStack {
                HStack(spacing: 16) {
                    ProfileImageView(image: viewModel.avatar)
                        .onTapGesture { viewModel.isShowingPhotoPicker = true }
                    
                    VStack(spacing: 1) {
                        TextField.init("First Name", text: $viewModel.firstName) .profileNameStyle()
                        TextField.init("Last Name", text: $viewModel.lastName).profileNameStyle()
                        TextField.init("Company Name", text: $viewModel.companyName)
                    }
                    .padding(.trailing, 16)
                }
                .padding(.vertical)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
                
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        CharactersRemainView(currentCount: viewModel.bio.count)
                            .accessibilityAddTraits(.isHeader)
                        Spacer()
                        
                        if viewModel.isCheckedIn {
                            Button {
                                viewModel.checkOut()
                                HapticManager.playSuccess()
                            } label: {
                                CheckOutButton()
                            }
                            .disabled(viewModel.isLoading)
                        }
                    }
                    
                    BioTextEditor(text: $viewModel.bio)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                Button {
                    viewModel.determineButtonAcion()
                } label: {
                    DDGButton(title: viewModel.buttonTitle)
                }
                .padding(.bottom)
            }
            
            if viewModel.isLoading { LoadingView() }
            
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(DeviceTypes.isiPhone8Standard ? .inline : .automatic)
        .toolbar {
            Button {
                dismissKeyboard()
            } label: {
                Image(systemName: "keyboard.chevron.compact.down")
            }
        }
        .onAppear { 
            viewModel.getProfile()
            viewModel.getCheckedInStatus()
        }
        .alert(item: $viewModel.alertItem, content: { $0.alert })
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

fileprivate struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
    }
}

fileprivate struct ProfileImageView: View {
    
    var image: UIImage
    
    var body: some View {
        ZStack {
            AvatarView(image: image, size: 84)
            
            Image(systemName: "square.and.pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
                .foregroundStyle(.white)
                .offset(y: 30)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(Text("Profile Photo"))
        .accessibilityHint(Text("Opens the iPhone's photo picker."))
        .padding(.leading, 12)
    }
}

fileprivate struct CharactersRemainView: View {
    
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

struct CheckOutButton: View {
    
    var body: some View {
        Label("Check Out", systemImage: "mappin.and.ellipse")
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(.white)
            .padding(10)
            .frame(height: 28)
            .background(Color.grubRed)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .accessibilityLabel(Text("Check out of current location."))
    }
}

struct BioTextEditor: View {
    
    var text: Binding<String>
    
    var body: some View {
        TextEditor(text: text)
            .frame(height: 100)
            .overlay { RoundedRectangle(cornerRadius: 8).stroke(Color.secondary, lineWidth: 1) }
            .accessibilityHint(Text("This TextField has a 100 character maximum."))
    }
}
