//
//  SimpleButton.swift
//  BestFitMe
//
//  Created by Титов Валентин on 22/04/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class SimpleButton: Button {

  override func applyStyle() {
    titleLabel?.font = .simpleButton
    setTitleColor(.accent, for: .normal)
    let hsbAccent: HSB = UIColor.accent.getHSB()
      setTitleColor(UIColor.init(hue: hsbAccent.hue,
                                 saturation: hsbAccent.saturation*AppButton.kPressDeltaColorCoefficient,
                                 brightness: hsbAccent.brightness,
                                 alpha: hsbAccent.alpha), for: .highlighted)
  }

}

class DefaultBoldButton: SimpleButton {
  override func applyStyle() {
    super.applyStyle()
    titleLabel?.font = .button
  }
}

class DefaultSimpleButton: SimpleButton {
  override func applyStyle() {
    super.applyStyle()
    titleLabel?.font = .button
  }
}

class SmallSimpleButton: SimpleButton {
  override func applyStyle() {
    super.applyStyle()
    setTitleColor(.primary, for: .normal)
    titleLabel?.font = .small
  }
}
