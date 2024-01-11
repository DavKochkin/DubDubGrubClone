//
//  CKAssets+Ext.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 11.01.2024.
//

import CloudKit
import UIKit

extension CKAsset {
    func convertToUIImage(in dimension: ImageDimension) -> UIImage {
        let placeholder = ImageDimension.getPlaceholder(for: dimension)
        
        guard let fileUlr = self.fileURL else { return placeholder }
        
        do {
            let data = try Data(contentsOf: fileUlr)
            return UIImage(data: data) ?? placeholder
        }
        catch {
            return placeholder
        }
    }
}
