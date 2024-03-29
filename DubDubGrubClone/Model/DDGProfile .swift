//
//  DDGProfile .swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 07.01.2024.
//
import UIKit
import CloudKit

struct DDGProfile: Identifiable {
    
    static let kFirstName           = "firstName"
    static let kLastName            = "lastName"
    static let kAvatar              = "avatar"
    static let kCompanyName         = "companyName"
    static let kBio                 = "bio"
    static let kIsCheckedIn         = "isCheckedIn"
    static let kisCheckedInNilCheck = "isCheckedInNilCheck"
    
    let id: CKRecord.ID
    let firstName: String
    let lastName: String
    let avatar: CKAsset!
    let companyName: String
    let bio: String
    
    init(record: CKRecord) {
        id           = record.recordID
        firstName    = record[DDGProfile.kFirstName] as? String ?? "N/A"
        lastName     = record[DDGProfile.kLastName] as? String ?? "N/A"
        avatar       = record[DDGProfile.kAvatar] as? CKAsset
        companyName  = record[DDGProfile.kCompanyName] as? String ?? "N/A"
        bio          = record[DDGProfile.kBio] as? String ?? "N/A"
    }
    
    func createAvatarImage() -> UIImage {
        guard let avatar else { return PlaceholderImage.avatar }
        return avatar.convertToUIImage(in: .square)
    }
}
