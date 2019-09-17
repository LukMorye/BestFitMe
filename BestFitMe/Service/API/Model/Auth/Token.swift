//
//  Token.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import Foundation

struct Token: Codable {
  
  var accessToken:String!
  var refreshToken: String!
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
  }
  
}
