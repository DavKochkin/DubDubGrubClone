//
//  Constants.swift
//  DubDubGrubClone
//
//  Created by David Kochkin on 08.01.2024.
//

import Foundation
import UIKit


enum RecordType {
    static let location = "DDGLocation"
    static let profile  = "DDGProfile"
}

enum PlaceholderImage {
    static let avatar = UIImage(named: "default-avatar")!
    static let square = UIImage(named: "default-square-asset")!
    static let banner = UIImage(named: "default-banner-asset")!
}

enum ImageDimension {
    case square, banner
    
   static func getPlaceholder(for dimension: ImageDimension) -> UIImage {
        return dimension == .square ? PlaceholderImage.square : PlaceholderImage.banner
    }
}
