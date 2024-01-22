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
            // Show an aler
            return
        }
        
        // Create reference on UserRecord to the DDGProfile we created
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result in
            switch result {
            case .success(_):
                // show alert
                break
            case .failure(_):
                // show alert
                break
            }
        }
    }
    
    func getProfile() {
        
        guard let userRecord = CloudKitManager.shared.userRecord else {
            // show alert
            return
        }
        
        guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else { return }
        
        let profileRecordID = profileReference.recordID
        
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
            switch result {
            case .success(let record):
                    let profile = DDGProfile(record: record)
                    firstName   = profile.firstName
                    lastName    = profile.lastName
                    companyName = profile.companyName
                    bio         = profile.bio
                    avatar      = profile.createAvatarImage()
                    
                case .failure(_):
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
}
