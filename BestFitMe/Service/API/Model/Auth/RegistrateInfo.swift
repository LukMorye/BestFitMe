//
//  RegistrateInfo.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import Foundation

struct RegistrateInfo: Codable {
  
  let userInfo: UserRegInfo
  
  private enum CodingKeys: String, CodingKey {
    case userInfo = "user_info"
  }
  
}

struct UserRegInfo: Codable {
 
  let identifier: Int64
  let userName: String
  let email: String
  let registrationDate: Double
  
  /* Api keys */
  private enum CodingKeys: String, CodingKey {
    case identifier = "id",
    userName = "username",
    email = "email",
    registrationDate = "registration_date"
  }
}
