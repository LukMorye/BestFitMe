//
//  FilledButton.swift
//  Job
//
//  Created by Титов Валентин on 15.02.2019.
//  Copyright © 2019 True North. All rights reserved.
//

import UIKit

class FilledButton: AppButton {

  override var isEnabled: Bool {
    didSet {
      if isEnabled {
        backgroundColor = .accent
        setTitleColor(.secondary, for: .normal)
      } else {
        backgroundColor = .minor
      }
    }
  }
  
  override func applyStyle() {
    super.applyStyle()
    backgroundColor = .primary
    setTitleColor(.secondary, for: .normal)
  }
  
  func fillLeftIcon(image: UIImage) {
    super.fillLeftIcon(image: image,
                       tintColor: .secondary)
  }
  
  func fillRightLabel(text: String) {
    super.fillRightLabel(text: text,
                         textColor: .secondary)
  }
  
  override func pressed() {
    let hsbAccent: HSB = UIColor.primary.getHSB()
    let pressedColor = UIColor.init(hue: hsbAccent.hue,
                                    saturation: hsbAccent.saturation*AppButton.kPressDeltaColorCoefficient,
                                    brightness: hsbAccent.brightness,
                                    alpha: hsbAccent.alpha)
    UIView.animate(withDuration: AnimationSpeed.speed3.rawValue) {
      self.backgroundColor = pressedColor
    }
    
  }
  
  override func released() {
    UIView.animate(withDuration: AnimationSpeed.speed3.rawValue) {
      self.backgroundColor = .primary
    }
  }

}
