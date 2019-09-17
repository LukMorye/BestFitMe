//
//  UIColorExtension.swift
//  TrueNorth
//
//  Created by Valentin Titov on 10.09.16.
//  Copyright © 2016 Titov Valentin. All rights reserved.
//

import UIKit

fileprivate let kOne:CGFloat = 1.0
fileprivate let kHexPrefix = "#"


extension UIColor {
    
  public static let maxRGB: CGFloat = 255.0

  //MARK: Background colors
  static var primary: UIColor { return colorFrom(r: 130.0, g: 190.0, b: 232.0) }
  static var secondary: UIColor { return colorFrom(r: maxRGB, g: maxRGB, b: maxRGB) }
  static var accent: UIColor { return colorFrom(r: 61.0, g: 118.0, b: 204.0) }
  static var background: UIColor { return colorFrom(r: 244.0, g: 246.0, b: 250.0, a: 1.0) }
  static var minor: UIColor { return colorFrom(r: 208.0, g: 208.0, b: 208.0) }
  static var nuance: UIColor { return colorFrom(r: 224.0, g: 224.0, b: 224.0) }
  static var snow: UIColor { return colorFrom(r: 238.0, g: 240.0, b: 241.0) }
  static var error: UIColor { return colorFrom(r: 221.0, g: 34.0, b: 54.0) }
  static var grayTranscluent: UIColor { return colorFrom(r: 240.0, g: 240.0, b: 240.0, a: 0.3) }
  static var appYellow: UIColor { return colorFrom(r: 242.0, g: 201.0, b: 76.0) }
  //MARK: Text colors
  static var textPrimary: UIColor { return colorFrom(r: 51.0, g: 51.0, b: 51.0) }
  static var textLink: UIColor { return colorFrom(r: 243.0, g: 237.0, b: 84.0) }
  static var textOther: UIColor { return colorFrom(r: 156.0, g: 158.0, b: 185.0) }
  
  
  static func colorFrom(r:CGFloat,
                        g:CGFloat,
                        b:CGFloat,
                        a:CGFloat = kOne) -> UIColor {
    return UIColor(red: r/maxRGB,
                   green: g/maxRGB,
                   blue: b/maxRGB,
                   alpha: a)
  }
  
  static func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix(kHexPrefix)) {
        cString.remove(at: cString.startIndex)
    }
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / maxRGB,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / maxRGB,
        blue: CGFloat(rgbValue & 0x0000FF) / maxRGB,
        alpha: CGFloat(1.0))
  }

  func getHSB() -> HSB {
    var hue: CGFloat = .zero
    var saturation: CGFloat = .zero
    var brightness: CGFloat = .zero
    var alpha: CGFloat = .zero
    _ = self.getHue(&hue,
                    saturation: &saturation,
                    brightness: &brightness,
                    alpha: &alpha)
    return HSB(hue: hue,
               saturation: saturation,
               brightness: brightness,
               alpha: alpha)
  }
  
}


class HSB {
  let hue: CGFloat
  let saturation: CGFloat
  let brightness: CGFloat
  let alpha: CGFloat
  
  init(hue: CGFloat,
       saturation: CGFloat,
       brightness: CGFloat,
       alpha: CGFloat) {
    self.hue = hue
    self.saturation = saturation
    self.brightness = brightness
    self.alpha = alpha
  }
}
