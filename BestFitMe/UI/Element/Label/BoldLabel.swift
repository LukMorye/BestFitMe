//
//  BoldLabel.swift
//  BestFitMe
//
//  Created by Титов Валентин on 18/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class BoldLabel: Label {

  override func applyStyle() {
    super.applyStyle()
    font = .boldText
    textColor = .textPrimary
    textAlignment = .left
    numberOfLines = 0
  }

}
