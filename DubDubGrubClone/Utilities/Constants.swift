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


enum DeviceTypes {
    enum ScreenSize {
        static let width     = UIScreen.main.bounds.size.width
        static let height    = UIScreen.main.bounds.size.height
        static let maxLenght = max(ScreenSize.width, ScreenSize.height)
        static let minLenght = min(ScreenSize.width, ScreenSize.height)
    }
    
    static let idiom       = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale       = UIScreen.main.scale
    
    static let isiPhoneSE            = idiom == .phone && ScreenSize.maxLenght == 568.0
    static let isiPhone8Standard     = idiom == .phone && ScreenSize.maxLenght == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed       = idiom == .phone && ScreenSize.maxLenght == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard = idiom == .phone && ScreenSize.maxLenght == 736.0
    static let isiPhone8PlusZoomed   = idiom == .phone && ScreenSize.maxLenght == 736.0 && nativeScale > scale
    static let isiPhoneX             = idiom == .phone && ScreenSize.maxLenght == 812.0
    static let isiPhoneXsMaxAndXr    = idiom == .phone && ScreenSize.maxLenght == 896.0
    static let isiPad                = idiom == .pad && ScreenSize.maxLenght >= 1024.0
    
    
    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
