//
//  LegalRequest.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class LegalRequest: ApiRequest {

  var path: String = .empty
  var method: RequestType = .get
  var contentType: ContentType = .json
  var isBody: Bool = false
  var parameters: [String : Any]?
  var binaryData: Data?
  

  init(location: String) {
    self.path = "\(ApiClient.apiVersion)/legal/\(location)"
  }
  
}
