//
//  SpringDamping.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

typealias SpringDamping = CGFloat

enum AppSpringDamping: SpringDamping {
  case lite = 0.9
  case medium = 0.75
  case strong = 0.5
}
