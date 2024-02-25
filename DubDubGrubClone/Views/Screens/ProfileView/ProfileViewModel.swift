//
//  ProfileViewModel.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 21.01.2024.
//

import Foundation
import CloudKit

enum ProfileContext { case create, update }

extension ProfileView {
    
    final class ProfileViewModel: ObservableObject {
        
        @Published var firstName   = ""
        @Published var lastName    = ""
        @Published var companyName = ""
        @Published var bio         = ""
        @Published var avatar      = PlaceholderImage.avatar
        @Published var isShowingPhotoPicker = false
        @Published var isLoading   = false
        @Published var isCheckedIn = false
        @Published var alertItem: AlertItem?
        
        private var existingProfileRecord: CKRecord? {
            didSet { profileContext = .update }
        }
        
        var profileContext: ProfileContext = .create
        var buttonTitle: String { profileContext == .create ? "Create Profile" : "Update Profile" }
        
        
        private func isValidProfile() -> Bool {
            guard !firstName.isEmpty,
                  !lastName.isEmpty,
                  !companyName.isEmpty,
                  !bio.isEmpty,
                  avatar != PlaceholderImage.avatar,
                  bio.count <= 100 else { return false }
            
            return true
        }
        
        
        func getCheckedInStatus() {
            guard let profileRecordID = CloudKitManager.shared.profileRecordID else { return }
            
            Task {
                do {
                    let record = try await CloudKitManager.shared.fetchRecord(with: profileRecordID)
                    if let _ = record[DDGProfile.kIsCheckedIn] as? CKRecord.Reference {
                        isCheckedIn = true
                    } else {
                        isCheckedIn = false
                    }
                } catch {
                    print("Unable to get checked in status")
                }
            }
        }
        
        
        func checkOut() {
            guard let profileID = CloudKitManager.shared.profileRecordID else {
                alertItem = AlertContext.unableToGetProfile
                return
            }
            
            showLoadingView()
            
            Task {
                do {
                    let record = try await CloudKitManager.shared.fetchRecord(with: profileID)
                    record[DDGProfile.kIsCheckedIn] = nil
                    record[DDGProfile.kisCheckedInNilCheck] = nil
                    
                    let _ = try await CloudKitManager.shared.save(record: record)
                    HapticManager.playSuccess()
                    isCheckedIn = false
                    hideLoadingView()
                } catch {
                    hideLoadingView()
                    alertItem = AlertContext.unableToGetCheckInOrOut
                }
            }
        }
        
        
        func determineButtonAcion() {
            profileContext == .create ? createProfile() : updateProfile()
        }
        
        
        private func createProfile() {
            
            guard isValidProfile() else {
                alertItem = AlertContext.invalidProfile
                return
            }
            // Create our CKRecord from the profile view
            let profileRecord = createProfileRecord()
            guard let userRecord = CloudKitManager.shared.userRecord else {
                alertItem = AlertContext.noUserRecord
                return
            }
            
            // Create reference on UserRecord to the DDGProfile we created
            userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
            
            showLoadingView()
            
            Task {
                do {
                    let records = try await CloudKitManager.shared.batchSave(records: [userRecord, profileRecord])
                    for record in records where record.recordType == RecordType.profile {
                        existingProfileRecord = record
                        CloudKitManager.shared.profileRecordID = record.recordID
                    }
                    alertItem = AlertContext.createProfileSuccess
                } catch {
                    hideLoadingView()
                    alertItem = AlertContext.createProfileFailure
                }
            }
        }
        
        
        func getProfile() {
            guard let userRecord = CloudKitManager.shared.userRecord else {
                alertItem = AlertContext.noUserRecord
                return
            }
            
            guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else { return }
            let profileRecordID = profileReference.recordID
            
            showLoadingView()
            
            Task {
                do {
                    let record = try await CloudKitManager.shared.fetchRecord(with: profileRecordID)
                    existingProfileRecord = record
                    let profile = DDGProfile(record: record)
                    firstName   = profile.firstName
                    lastName    = profile.lastName
                    companyName = profile.companyName
                    bio         = profile.bio
                    avatar      = profile.createAvatarImage()
                    
                    hideLoadingView()
                } catch {
                    alertItem = AlertContext.unableToGetProfile
                }
            }
        }
        
        
        private func updateProfile() {
            guard isValidProfile() else {
                alertItem = AlertContext.invalidProfile
                return
            }
            
            guard let existingProfileRecord else {
                alertItem = AlertContext.unableToGetProfile
                return
            }
            
            existingProfileRecord[DDGProfile.kFirstName]   = firstName
            existingProfileRecord[DDGProfile.kLastName]    = lastName
            existingProfileRecord[DDGProfile.kCompanyName] = companyName
            existingProfileRecord[DDGProfile.kBio]         = bio
            existingProfileRecord[DDGProfile.kAvatar]      = avatar.convertToCKAsset()
            
            showLoadingView()
            
            Task {
                do {
                    let _ = try await CloudKitManager.shared.save(record: existingProfileRecord)
                    hideLoadingView()
                    alertItem = AlertContext.updateProfileSuccess
                } catch {
                    hideLoadingView()
                    alertItem = AlertContext.updateProfileFailure
                }
            }
        }
        
        private func createProfileRecord() -> CKRecord {
            let profileRecord = CKRecord(recordType: RecordType.profile)
            
            profileRecord[DDGProfile.kFirstName]   = firstName
            profileRecord[DDGProfile.kLastName]    = lastName
            profileRecord[DDGProfile.kCompanyName] = companyName
            profileRecord[DDGProfile.kBio]         = bio
            profileRecord[DDGProfile.kAvatar]      = avatar.convertToCKAsset()
            
            return profileRecord
        }
        
        private func showLoadingView() { isLoading = true }
        private func hideLoadingView() { isLoading = false }
    }
    
}
