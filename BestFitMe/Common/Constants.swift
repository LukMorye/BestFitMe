//
//  Constants.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit


struct Constants {
  
  static let storyboardName = "Main"
  static let kPasswordMinLength: Int = 6
  //MARK: Shadow
  static var shadowSize:CGFloat = 1.0
  static var shadowOpacity:CGFloat = 0.5
  static var shadowRadius:CGFloat = 15.0
  //MARK: Corners
  static let corner:CGFloat = 15.0 * sizeAspect.rawValue
  //MARK: Scale factor
  static let minimumScaleFactor:CGFloat = 0.5
  

  
  /* Device aspects */
  static var sizeAspect:DeviceSizeAspect {
    get {
      switch UIDevice.device {
      case .iPhoneDefault,.iPhoneX,.iPhoneMax, .simulator: return .defFactor
      case .iPhoneSE: return .seFactor
      case .iPad97: return .iPad97SizeAspect
      case .iPad105: return .iPad105SizeAspect
      case .iPad129: return .iPad129SizeAspect
      }
    }
  }
  
  static var fontAspect:DeviceFontAspect {
    get {
      switch UIDevice.device {
      case .iPhoneDefault,.iPhoneX,.iPhoneMax, .simulator: return .defFactor
      case .iPhoneSE: return .seFactor
      case .iPad97: return .iPad97SizeAspect
      case .iPad105: return .iPad105SizeAspect
      case .iPad129: return .iPad129SizeAspect
      }
    }
  }
  
  
  /* Grid system */
  static let rowCount: CGFloat = 6.0
  static var rowWidth: CGFloat {
    get {
      return (screenSize.width - ((rowCount - 1.0)*gutter) - offset * 2.0)/rowCount
    }
  }

  static var offset: CGFloat {
    get { return (UIDevice.current.userInterfaceIdiom == .phone) ? 15.0 : 35.0 }
  }

  static var gutter: CGFloat {
    get { return (UIDevice.current.userInterfaceIdiom == .phone) ? 12.0 : 20.0 }
  }
  
  /* Paddings */
  static var padding5:CGFloat { get{ return 5.0 * sizeAspect.rawValue}}
  static var padding10:CGFloat { get{ return 10.0 * sizeAspect.rawValue}}
  static var padding20:CGFloat { get{ return 20.0 * sizeAspect.rawValue}}
  static var padding40:CGFloat { get{ return 40.0 * sizeAspect.rawValue}}

  /* Default common sizes */
  static var viewHeight:CGFloat {
    get { return (UIDevice.current.userInterfaceIdiom == .phone) ? 44.0 : rowWidth * 0.6 }
  }
  static var topBarHeight: CGFloat { get { return 65.0 * Constants.sizeAspect.rawValue }}
  static var previewCardWidth:CGFloat { get { return 250.0 * sizeAspect.rawValue }}
  static var previewCardHeight:CGFloat { get { return 410.0 * sizeAspect.rawValue }}
  /* Screen constants */
  static var screenSize:CGSize { get { return UIScreen.main.bounds.size }}
  static var screenWidth:CGFloat { get { return screenSize.width }}
  static var screenHeight:CGFloat { get { return screenSize.height }}
  static var screenAspect:CGFloat { get { return screenHeight/screenWidth }}
}




