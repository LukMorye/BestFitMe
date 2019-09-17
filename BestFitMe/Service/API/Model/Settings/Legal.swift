//
//  Legal.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import Foundation

struct Legal: Codable {
  
  let legal: String
  /* Api keys */
  private enum CodingKeys: String, CodingKey {
    case legal
  }
}
