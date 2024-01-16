//
//  LocationDetailView.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 01.01.2024.
//

import SwiftUI

struct LocationDetailView: View {
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var location: DDGLocation
    
    var body: some View {
        VStack {
            BannerImage(image: location.createBannerImage())
            
            HStack {
                AdressView(adressString: location.address)
                Spacer()
            }
            .padding(.horizontal)
            
            DescriptionView(text: location.description)
            
            ZStack {
                Capsule()
                    .frame(height: 80)
                    .foregroundStyle(Color(uiColor: .secondarySystemBackground))
                
                HStack(spacing: 20) {
                    Button {
                        
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "location.fill")
                    }
                    
                    Link(destination: URL(string: location.websiteURL)!, label: {
                        LocationActionButton(color: .brandPrimary, imageName: "network")
                    })
                    
                    Button {
                        
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "phone.fill")
                    }
                    
                    Button {
                        
                    } label: {
                        LocationActionButton(color: .brandPrimary, imageName: "person.fill.checkmark")
                    }
                }
            }
            .padding(.horizontal)
            
            Text("Who's Here?")
                .bold()
                .font(.title2)
            
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Sean")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "John")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "David")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Margo")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Ed")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Kevin")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Kevin")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Kevin")
                    FirstNameAvatarView(image: PlaceholderImage.avatar, firstName: "Kevin")
                })
            }
            Spacer()
        }
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        LocationDetailView(location: DDGLocation(record: MockData.location))
    }
}

struct LocationActionButton: View {
    
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

struct FirstNameAvatarView: View {
    
    var image: UIImage
    var firstName: String
    
    var body: some View {
        VStack {
            AvatarView(image: image, size: 64)
            
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

struct BannerImage: View {
    
    var image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct AdressView: View {
    
    var adressString: String
    
    var body: some View {
        Label(adressString, systemImage: "mappin.and.ellipse")
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}

struct DescriptionView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .frame(height: 70)
            .padding(.horizontal)
    }
}
