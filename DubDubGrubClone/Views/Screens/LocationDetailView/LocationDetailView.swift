//
//  LocationDetailView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 01.01.2024.
//

import SwiftUI

struct LocationDetailView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
        ZStack {
            VStack {
                BannerImage(image: viewModel.location.createBannerImage())
                AdressHStackView(adressString: viewModel.location.address)
                DescriptionView(text: viewModel.location.description)
                ActionButtonHStack(viewModel: viewModel)
                GridHeaderTextView(number: viewModel.checkInProfiles.count)
                AvatarGridView(viewModel: viewModel)
                Spacer()
            }
            .accessibilityHidden(viewModel.isShowingProfileModal)
            
            if viewModel.isShowingProfileModal {
                FullScreenBlackTransparencyView()
                ProfileModalView(isShowingProfileModal: $viewModel.isShowingProfileModal,
                                 profile: viewModel.selectedProfile!)
            }
        }
        .task {
            viewModel.getCheckedInProfiles()
            viewModel.getCheckedInStatus()
        }
        .alert(item: $viewModel.alertItem, content: { $0.alert })
        .navigationTitle(viewModel.location.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    NavigationView {
        LocationDetailView(viewModel: LocationDetailViewModel(location: DDGLocation(record: MockData.chipotle)))
    }
}


fileprivate struct LocationActionButton: View {
    
    var color: Color
    var imageName: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(color)
                .frame(width: 60, height: 60)
            
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 22, height: 22)
        }
    }
}


fileprivate struct FirstNameAvatarView: View {
    
    var profile: DDGProfile
    
    var body: some View {
        VStack {
            AvatarView(image: profile.createAvatarImage(), size: 64)
            
            Text(profile.firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(Text("Show's \(profile.firstName) profile pop up."))
        .accessibilityLabel(Text("\(profile.firstName) \(profile.lastName)"))
    }
}


fileprivate struct BannerImage: View {
    
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
            .accessibilityHidden(true)
    }
}


fileprivate struct AdressHStackView: View {
    
    var adressString: String
    
    var body: some View {
        HStack {
            Label(adressString, systemImage: "mappin.and.ellipse")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}


fileprivate struct DescriptionView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .frame(height: 70)
            .padding(.horizontal)
    }
}


fileprivate struct GridHeaderTextView: View {
    
    var number: Int
    
    var body: some View {
        Text("Who's Here?")
            .bold()
            .font(.title2)
            .accessibilityAddTraits(.isHeader)
            .accessibilityLabel(Text("Who's Here? \(number) checked in"))
            .accessibilityHint(Text("Bottom section in scrollable"))
    }
}


fileprivate struct GridEmptyStateTextView: View {
    
    var body: some View {
        Text("Nobody's Here 😢")
            .bold()
            .font(.title2)
            .foregroundColor(.secondary)
            .padding(.top, 30)
    }
}


fileprivate struct FullScreenBlackTransparencyView: View {
    
    var body: some View {
        Color(.black)
            .ignoresSafeArea()
            .opacity(0.9)
            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.35)))
            .zIndex(1)
            .accessibilityHidden(true)
    }
}


fileprivate struct ActionButtonHStack: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                viewModel.getDirectionsToLocation()
            } label: {
                LocationActionButton(color: .brandPrimary, imageName: "location.fill")
            }
            .accessibilityLabel(Text("Get directions"))
            
            Link(destination: URL(string: viewModel.location.websiteURL)!, label: {
                LocationActionButton(color: .brandPrimary, imageName: "network")
            })
            .accessibilityRemoveTraits(.isButton)
            .accessibilityLabel(Text("Go to website"))
            
            Button {
                viewModel.callLocation()
            } label: {
                LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
            }
            .accessibilityLabel(Text("Call location"))
            
            if let _ = CloudKitManager.shared.profileRecordID {
                Button {
                    viewModel.updateCheckInStatus(to: viewModel.isCheckedIn ? .checkedOut : .checkedIn)
                } label: {
                    LocationActionButton(color: viewModel.buttonColor,
                                         imageName: viewModel.buttonImageTitle)
                }
                .accessibilityLabel(Text(viewModel.buttonA11yLabel))
                .disabled(viewModel.isLoading)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .background(Color(.secondarySystemBackground))
        .clipShape(Capsule())
    }
}

fileprivate struct AvatarGridView: View {
    
    @ObservedObject var viewModel: LocationDetailViewModel
    
    var body: some View {
        ZStack {
            if viewModel.checkInProfiles.isEmpty {
                GridEmptyStateTextView()
            } else {
                ScrollView {
                    LazyVGrid(columns: viewModel.columns, content: {
                        ForEach(viewModel.checkInProfiles) { profile in
                            FirstNameAvatarView(profile: profile)
                                .onTapGesture {
                                    withAnimation { viewModel.selectedProfile = profile }
                                }
                        }
                    })
                }
            }
            if viewModel.isLoading { LoadingView() }
        }
    }
}
