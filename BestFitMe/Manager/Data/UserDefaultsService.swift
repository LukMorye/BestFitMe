//
//  UserDefaultsService.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit



class UserDefaultsService: NSObject {
  
  /* Keys */
  static let kUserName: String = "user_email"
  static let kPublicKey: String = "publicKey"
  static let kClassifiersUploaded: String = "classifiers_uploaded"
  static let kWaitingValidatePayment: String = "waiting_validate_payment"
  static let kValidatedPaymentList: String = "payment_list"

  /* Properties */
  private let userDefaults: UserDefaults = UserDefaults.standard
  let documentsURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  
  
  /* Implementation */
  override init() {}
  
  //MARK: Public Key
  func savePublicKey(key:String) {
    userDefaults.set(normalizedPublicKey(key: key),
                     forKey: UserDefaultsService.kPublicKey)
    userDefaults.synchronize()
  }
  
  private func normalizedPublicKey(key:String) -> String {
    let cuttedKey = key[..<key.index(before: key.endIndex)]
    let stringsArray: NSMutableArray = NSMutableArray.init(array: cuttedKey.components(separatedBy: "\n"))
    let firstObject: String = stringsArray.firstObject as! String
    let lastObject: String = stringsArray.lastObject as! String
    stringsArray.remove(lastObject)
    stringsArray.remove(firstObject)
    let normalizedKey: String = stringsArray.componentsJoined(by: "")
    return normalizedKey
  }
  
  static func publicKey() -> String {
    if UserDefaults.standard.value(forKey: kPublicKey) != nil && UserDefaults.standard.value(forKey: kPublicKey) is String {
      return UserDefaults.standard.value(forKey: kPublicKey) as! String
    }
    return .empty
  }
  
  //MARK: Token
  public func save(token: Token,
                   for user: String) {

      let keyChain: KeyChain = getKeyChain(for: user)
      guard let accessToken: String = token.accessToken,
        let refreshToken: String = token.refreshToken else {
          print("Token info is not valid")
          return
      }
      keyChain.save(service: Token.CodingKeys.accessToken.rawValue,
                    data: accessToken)
      keyChain.save(service: Token.CodingKeys.refreshToken.rawValue,
                    data: refreshToken)
      keyChain.save(service: UserDefaultsService.kUserName,
                    data: user)
      userDefaults.set(user,
                       forKey: UserDefaultsService.kUserName)
      userDefaults.synchronize()
    
  }

  public func getTokenModel() -> Token? {
    return Token(accessToken: getAccessToken(),
                 refreshToken: getRefreshToken())
  }

  public func getAccessToken() -> String? {
    if let user: String = getUser() {
      let keyChain: KeyChain = getKeyChain(for: user)
      do {
        return try keyChain.load(service: Token.CodingKeys.accessToken.rawValue)
      } catch {
        NSLog("LOG_Error_Settings-"+#function+"_LINE: \(#line)-->"+"Token is not found")
      }
    }
    return nil
  }

  public func getRefreshToken() -> String? {
    if let user: String = getUser() {
      let keyChain: KeyChain = getKeyChain(for: user)
      do {
        return try keyChain.load(service: Token.CodingKeys.refreshToken.rawValue)
      } catch {
        NSLog("LOG_Error_Settings-"+#function+"_LINE: \(#line)-->"+"Token is not found")
      }
    }
    return nil
  }

  public func getUser() -> String? {
    return userDefaults.value(forKey: UserDefaultsService.kUserName) as? String
  }

  public func resetUser() {
    if let user: String = getUser() {
      let keyChain: KeyChain = getKeyChain(for: user)
      keyChain.remove(service: Token.CodingKeys.accessToken.rawValue)
      keyChain.remove(service: Token.CodingKeys.refreshToken.rawValue)
    }
    userDefaults.removeObject(forKey: UserDefaultsService.kUserName)
    userDefaults.synchronize()
  }
  
  //MARK: Keychain
  private func getKeyChain(for login:String) -> KeyChain {
    let keyChain: KeyChain = KeyChain.init(accessGroup: Settings.shared.appName,
                                           userAccount: login)
    return keyChain
  }
}


//MARK: Products
extension UserDefaultsService {
  
  func newWaitingValidatePayment(by indentifier: String) {
    userDefaults.setValue(indentifier,
                          forKey: UserDefaultsService.kWaitingValidatePayment)
    userDefaults.synchronize()
  }
  
  func existWaitingValidationPayment() -> String? {
    return userDefaults.value(forKey: UserDefaultsService.kWaitingValidatePayment) as? String
  }
  
  func resetWaitingValidatePayment() {
    userDefaults.removeObject(forKey: UserDefaultsService.kWaitingValidatePayment)
    userDefaults.synchronize()
  }
}

  
//MARK: Uploaded Classifiers
extension UserDefaultsService {
  
  func setClassifiersUploaded() {
    userDefaults.set(true, forKey: UserDefaultsService.kClassifiersUploaded)
    userDefaults.synchronize()
  }
  
  func isClassifiersUploaded() -> Bool {
    return (userDefaults.value(forKey: UserDefaultsService.kClassifiersUploaded) as? NSNumber)?.boolValue ?? false
  }
  
}
