//
//  KeyChain.swift
//  Bestfit|Manager
//
//  Created by Титов Валентин on 30.05.2018.
//  Copyright © 2018 Valentin Titov. All rights reserved.
//

import UIKit
/**
 *  User defined keys for new entry
 *  Note: add new keys for new secure item and use them in load and save methods
 */
fileprivate let kTokenKey = "bfm_token_key"
fileprivate let kError = "error"

// Arguments for the keychain queries
fileprivate let kSecClassValue = NSString(format: kSecClass)
fileprivate let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
fileprivate let kSecValueDataValue = NSString(format: kSecValueData)
fileprivate let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)

fileprivate let kSecAttrServiceValue = NSString(format: kSecAttrService)
fileprivate let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
fileprivate let kSecReturnDataValue = NSString(format: kSecReturnData)
fileprivate let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

class KeyChain {
    
  /* Properties */
  private let userAccount:String
  private let accessGroup:String

  /* Implementation */
  init(accessGroup:String,
       userAccount:String) {
    self.accessGroup = accessGroup
    self.userAccount = userAccount
  }

  
  //MARK: Common implementation
  func save(service: String,
            data: String) {
    let dataFromString:Data =  data.data(using: .utf8, allowLossyConversion: false)!
    let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, dataFromString],
                                                                 forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
    SecItemDelete(keychainQuery as CFDictionary)
    SecItemAdd(keychainQuery as CFDictionary, nil)
  }
  
  func load(service: String) throws -> String {
      let keychainQuery: NSMutableDictionary = NSMutableDictionary(
        objects: [kSecClassGenericPasswordValue, service, userAccount, kCFBooleanTrue!, kSecMatchLimitOneValue],
        forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
      var dataTypeRef :AnyObject?
      let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
      var contentsOfKeychain:String
      if status == errSecSuccess {
          if let retrievedData = dataTypeRef as? Data {
              contentsOfKeychain = String.init(data: retrievedData, encoding: .utf8)!
              return contentsOfKeychain
          }
      }
      throw NSError.init(domain: Bundle.main.bundleIdentifier!,
                         code: Int(status),
                         userInfo: [kError:"Nothing was retrieved from the keychain. Status code \(status)"])
  }
  
  func remove(service: String) {
    let query: [String: Any] = [kSecClass as String: kSecClassInternetPassword,
                                kSecAttrServer as String: service]
    let status = SecItemDelete(query as CFDictionary)
    guard status == errSecSuccess || status == errSecItemNotFound else { return }
  }
}
