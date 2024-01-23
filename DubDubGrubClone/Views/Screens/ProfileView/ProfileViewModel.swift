//
//  ProfileViewModel.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 21.01.2024.
//

import Foundation
import CloudKit

final class ProfileViewModel: ObservableObject {
    
    @Published var firstName   = ""
    @Published var lastName    = ""
    @Published var companyName = ""
    @Published var bio         = ""
    @Published var avatar      = PlaceholderImage.avatar
    @Published var isShowingPhotoPicker = false
    @Published var isLoading   = false
    @Published var alertItem: AlertItem?
    
    func isValidProfile() -> Bool {
        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !companyName.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImage.avatar,
              bio.count <= 100 else { return false }
        
        return true
    }
    
    func createProfile() {
        
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
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                
                switch result {
                case .success(_):
                    alertItem = AlertContext.createProfileSuccess
                case .failure(_):
                    alertItem = AlertContext.createProfileFailure
                    break
                }
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
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                switch result {
                case .success(let record):
                    let profile = DDGProfile(record: record)
                    firstName   = profile.firstName
                    lastName    = profile.lastName
                    companyName = profile.companyName
                    bio         = profile.bio
                    avatar      = profile.createAvatarImage()
                    
                case .failure(_):
                    alertItem = AlertContext.unableToGetProfile
                    break
                }
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
