//
//  DeviceExtension.swift
//  TrueNorth
//
//  Created by Valentin on 07.09.16.
//  Copyright © 2016 Titov Valentin. All rights reserved.
//

import UIKit

fileprivate let kIPad = "iPad"
fileprivate let kIPhone = "iPhone"

enum DeviceModel:String {
    case iPodTouch5, iPodTouch6,
    iPhone4, iPhone4s, iPhone5, iPhone5c, iPhone5s, iPhoneSE,
    iPhone6, iPhone6s, iPhone7, iPhone8,
    iPhone6Plus, iPhone6sPlus, iPhone7Plus, iPhone8Plus, iPhoneX, iPhoneXS, iPhoneXSMax, iPhoneXR,
    iPadMini, iPadMini2, iPadMini3, iPadMini4,
    iPad2, iPad3, iPad4, iPadAir, iPadAir2, iPadPro, iPad5, iPadPro10, iPad2018,
    iPadPro12Inch,  iPadPro12Inch2, iPadPro11,iPadPro12Inch3,
    appleTV, simulator, unknown
}

extension UIDevice {
    static var modelName: DeviceModel {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce(String.empty) { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return .iPodTouch5
        case "iPod7,1":                                 return .iPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return .iPhone4
        case "iPhone4,1":                               return .iPhone4s
        case "iPhone5,1", "iPhone5,2":                  return .iPhone5
        case "iPhone5,3", "iPhone5,4":                  return .iPhone5c
        case "iPhone6,1", "iPhone6,2":                  return .iPhone5s
        case "iPhone7,2":                               return .iPhone6
        case "iPhone7,1":                               return .iPhone6Plus
        case "iPhone8,1":                               return .iPhone6s
        case "iPhone8,2":                               return .iPhone6sPlus
        case "iPhone8,4":                               return .iPhoneSE
        case "iPhone9,1", "iPhone9,3":                  return .iPhone7
        case "iPhone9,2", "iPhone9,4":                  return .iPhone7Plus
        case "iPhone10,1", "iPhone10,3":                return .iPhone8
        case "iPhone10,2", "iPhone10,4":                return .iPhone8Plus
        case "iPhone10,5", "iPhone10,6":                return .iPhoneX
        case "iPhone11,2":                              return .iPhoneXS
        case "iPhone11,4", "iPhone11,6":                return .iPhoneXSMax
        case "iPhone11,8":                              return .iPhoneXR
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return .iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3":           return .iPadAir
        case "iPad5,3", "iPad5,4":                      return .iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":           return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return .iPadMini3
        case "iPad5,1", "iPad5,2":                      return .iPadMini4
        case "iPad6,3", "iPad6,4":                      return .iPadPro
        case "iPad6,7", "iPad6,8":                      return .iPadPro12Inch
        case "iPad6,11","iPad6,12":                     return .iPad5
        case "iPad7,1", "iPad7,2":                      return .iPadPro12Inch2
        case "iPad7,3", "iPad7,4":                      return .iPadPro10
        case "iPad7,5", "iPad7,6":                      return .iPad2018
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return .iPadPro11
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return .iPadPro12Inch3
        case "AppleTV1,1","AppleTV2,1","AppleTV3,1",
             "AppleTV3,2","AppleTV5,3","AppleTV6,2":    return .appleTV
        case "i386", "x86_64":                          return .simulator
        default:                                        return .unknown
        }
    }
    
    
    static var device:DeviceType {
      switch UIDevice.current.userInterfaceIdiom {
      case .pad:
        let screenSize = UIScreen.main.bounds.size
        let height = max(screenSize.width, screenSize.height)
        switch height {
        case 1024: return .iPad97
        case 1112: return .iPad105
        case 1366: return .iPad129
        default: return .iPad97
        }
      case .phone:
        switch modelName {
        case .iPhone5,.iPhone5c,.iPhone5s,.iPhoneSE: return .iPhoneSE
        case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus, .iPhoneXR,.iPhoneXSMax: return .iPhoneMax
        case .iPhoneX, .iPhoneXS: return .iPhoneX
        case .simulator : return .simulator
        default: return .iPhoneDefault
        }
      default: return .iPhoneDefault
      }
    }

  
    
    static func systemVersionLessThan(version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version,
                                                      options: NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
    }
    static var window:UIWindow? {
        return (UIApplication.shared.delegate as? AppDelegate)?.window
    }
    static var screenSize:CGSize? {
        return window?.frame.size
    }
    static var screenFrame:CGRect? {
        return window?.frame
    }
    static var statusBarHeight:CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }


}
