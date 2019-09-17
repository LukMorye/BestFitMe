//
//  DeviceAspect.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

typealias Aspect = CGFloat

enum DeviceSizeAspect: Aspect {
  case seFactor = 0.66
  case defFactor = 1.0
  case maxFactor = 1.09
  case xFactor = 1.01
  case iPad97SizeAspect = 2.0
  case iPad105SizeAspect = 2.09
  case iPad129SizeAspect = 2.33
}

enum DeviceFontAspect: Aspect {
  case seFactor = 0.83
  case defFactor = 1.0
  case maxFactor = 1.09
  case xFactor = 1.01
  case iPad97SizeAspect = 1.375
  case iPad105SizeAspect = 1.5
  case iPad129SizeAspect = 1.66
}

