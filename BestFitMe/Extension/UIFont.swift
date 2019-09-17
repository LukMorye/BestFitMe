//
//  UIFontExtension.swift
//  TrueNorth
//
//  Created by Valentin Titov on 11.09.16.
//  Copyright © 2016 Titov Valentin. All rights reserved.
//

import UIKit

let fIBMPlexSansBold: String = "IBMPlexSans-Bold"
let fIBMPlexSansSemiBold: String = "IBMPlexSans-SemiBold"
let fIBMPlexSansRegular: String = "IBMPlexSans"
let fIBMPlexSansMedium: String = "IBMPlexSans-Medium"
let fIBMPlexSansLight: String = "IBMPlexSans-Light"
let fIBMPlexSansExtraLight: String = "IBMPlexSans-ExtraLight"
let fIBMPlexSansThin: String = "IBMPlexSans-Thin"


extension UIFont {
  /* Headers */
  static var h1:UIFont { get { return UIFont.init(name: fIBMPlexSansRegular,
                                                  size: 22.0*Constants.fontAspect.rawValue)! }}
  static var h2:UIFont { get { return UIFont.init(name: fIBMPlexSansRegular,
                                                  size: 14.0*Constants.fontAspect.rawValue)! }}
  static var h3:UIFont { get { return UIFont.init(name: fIBMPlexSansRegular,
                                                  size: 17.0*Constants.fontAspect.rawValue)! }}
  static var h4:UIFont { get { return UIFont.init(name: fIBMPlexSansRegular,
                                                  size: 16.0*Constants.fontAspect.rawValue)! }}
  static var h5:UIFont {
    get { return UIFont.init(name: fIBMPlexSansSemiBold,
                             size: 16.0*Constants.fontAspect.rawValue)! }}
  static var h6:UIFont { get { return UIFont.init(name: fIBMPlexSansBold,
                                                  size: 18.0*Constants.fontAspect.rawValue)! }}
  /* Texts */
  static var boldText:UIFont { get { return UIFont.init(name: fIBMPlexSansBold,
                                                        size: 15.0*Constants.fontAspect.rawValue)! }}
  static var text:UIFont { get { return UIFont.init(name: fIBMPlexSansRegular,
                                                    size: 15.0*Constants.fontAspect.rawValue)! }}
  static var small:UIFont { get { return UIFont.init(name: fIBMPlexSansRegular,
                                                     size: 14.0*Constants.fontAspect.rawValue)! }}
  static var headerPercent:UIFont { get { return UIFont.init(name: fIBMPlexSansBold,
                                                             size: 14.0*Constants.fontAspect.rawValue)! }}
  static var normalPercent:UIFont { get { return UIFont.init(name: fIBMPlexSansRegular,
                                                             size: 12.0*Constants.fontAspect.rawValue)! }}
  static var lowerCase:UIFont { get { return UIFont.init(name: fIBMPlexSansRegular,
                                                         size: 10.0*Constants.fontAspect.rawValue)! }}
  static var error:UIFont { get { return UIFont.init(name: fIBMPlexSansRegular,
                                                     size: 12.0*Constants.fontAspect.rawValue)! }}
  /* Buttons */
  static var button:UIFont { get { return UIFont.init(name: fIBMPlexSansBold,
                                                      size: 16.0*Constants.fontAspect.rawValue)! }}
  static var simpleButton:UIFont { get { return UIFont.init(name: fIBMPlexSansMedium,
                                                      size: 15.0*Constants.fontAspect.rawValue)! }}
  
}
