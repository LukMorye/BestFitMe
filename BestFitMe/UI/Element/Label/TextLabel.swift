//
//  TextLabel.swift
//  Demokit
//
//  Created by Титов Валентин on 17.07.2018.
//  Copyright © 2018 True North. All rights reserved.
//

import UIKit

class TextLabel: Label {

    override func applyStyle() {
        super.applyStyle()
        font = .text
        textColor = .textPrimary
        textAlignment = .left
        numberOfLines = 0
    }

}
