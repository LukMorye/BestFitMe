//
//  SettingsRequest.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class SettingsRequest: ApiRequest {
  
  var method: RequestType = .get
  
  var contentType: ContentType = .json
  
  var path: String = .empty
  
  var isBody: Bool = false
  
  var parameters: [String : Any]?
  
  var binaryData: Data?
  

}
