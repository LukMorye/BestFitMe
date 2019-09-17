//
//  AuthRequest.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class AuthRequest: ApiRequest {
  
  /* Api keys */
  private let kAccount: String = "account"
  private let kAccountSignIn: String = "auth"
  static let kEmail: String = "email"
  static let kPassword: String = "password"  
  static let kDeviceModel: String = "device_model"
  static let kDeviceOS: String = "device_os"
  static let kDeviceLang: String = "device_lang"
  static let kAppVersion: String = "app_version"
  static let kIdfa: String = "ios_ifa"
  
  /* Properties */
  var method: RequestType = .post
  var contentType: ContentType = .json
  var path: String = .empty
  var isBody: Bool = true
  var parameters: [String : Any]?
  var binaryData: Data?  
  
  //MARK: Implementation
  init(parameters: [String:Any]) {
    self.path = "\(ApiClient.apiVersion)/\(kAccount)/\(kAccountSignIn)"
    self.parameters = parameters
  }
  
}
