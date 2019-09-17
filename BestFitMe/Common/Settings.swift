//
//  Settings.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

fileprivate let kCFBundleShortVersionString: String =  "CFBundleShortVersionString"

/* Global settings */



class Settings {
  /* Single instance */
  static let shared: Settings = Settings()
  
  let appName: String = "BestFitMe"
  let buildType: BuildType = .dev
  let market: Market = .ru
  
  private let internalQueue = DispatchQueue(label: "SettingsInternalQueue",
                                            qos: .default,
                                            attributes: .concurrent)
  
  /* Api constants */
  /* Example thread safety variable for singleton */
  private var _supportNumber: String = "+79291112233"
  private(set) var supportNumber: String {
    get {
      return internalQueue.sync { _supportNumber }
    }
    set (newState) {
      internalQueue.async(flags: .barrier) { self._supportNumber = newState }
    }
  }
  private(set) var supportEmail: String! = "support@bestfitme.com"
  private(set) var analysePhotoCount: Int! = 1
  var serverDate: TimeInterval?
  
  
  //MARK: Application Version
  static func appVersion() -> String {
    return Bundle.main.infoDictionary![kCFBundleShortVersionString] as! String
  }
  
  //MARK: Lang
  static func langId() -> AppLang {
    let locale: String = Bundle.main.preferredLocalizations.first! as String
    guard locale.count >= 2 else {
      assertionFailure("it should be")
      return AppLang.en
    }
    let lastTwoChars: Range<String.Index> = locale.index(locale.endIndex, offsetBy: -2) ..< locale.endIndex
    let langStr: String = locale[lastTwoChars].lowercased()
    if let lang: AppLang = AppLang(rawValue: langStr) {
      return lang
    }
    return .en
  }
}

