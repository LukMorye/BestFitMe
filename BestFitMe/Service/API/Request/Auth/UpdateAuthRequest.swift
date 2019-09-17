//
//  UpdateAuthRequest.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class UpdateAuthRequest: ApiRequest {
  
  var method: RequestType = .post
  
  var contentType: ContentType = .json
  
  var path: String = .empty
  
  var isBody: Bool = true
  
  var parameters: [String : Any]?
  
  var binaryData: Data?
  

}
