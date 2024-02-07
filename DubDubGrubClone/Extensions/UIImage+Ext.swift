//
//  UIImage+Ext.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 18.01.2024.
//

import CloudKit
import UIKit

extension UIImage {
    
    func convertToCKAsset() -> CKAsset? {
        // Get our apps base document directory url
        guard let urlPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Document Directory url came back nil")
            return nil
        }

        // Append some unique identifier for our profile image
        let fileUrl = urlPath.appendingPathComponent("selectedAvatarImage")
        
        // Write the image data to the location the address points to
        guard let imageData = jpegData(compressionQuality: 0.25) else { return nil }
        
        // Create our CKAsset with that fileURL
        do {
            try imageData.write(to: fileUrl)
            return CKAsset(fileURL: fileUrl)
        }
        catch {
            return nil
        }
    }
}
