//
//  RegistrateRequest.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class RegistrateRequest: ApiRequest {
  
  /* Api keys */
  private let kAccount: String = "account"
  private let kAccountCreate: String = "create"
  static let kName: String = "username"
  static let kEmail: String = "email"
  static let kPassword: String = "password"
  static let kPhone: String = "phone"
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
  required init(parameters:[String: Any]) {
    self.path = "\(ApiClient.apiVersion)/\(kAccount)/\(kAccountCreate)"
    self.parameters = parameters
  }

}
