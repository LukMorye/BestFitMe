//
//  SmallLabel.swift
//  Demokit
//
//  Created by Титов Валентин on 01.08.2018.
//  Copyright © 2018 True North. All rights reserved.
//

import UIKit

class SmallLabel: Label {

    override func applyStyle() {
      super.applyStyle()
      font = .small
      textColor = .textPrimary
      textAlignment = .left
      numberOfLines = 0
    }

}
