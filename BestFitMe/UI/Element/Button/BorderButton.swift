//
//  BorderButton.swift
//  Job
//
//  Created by Титов Валентин on 15.02.2019.
//  Copyright © 2019 True North. All rights reserved.
//

import UIKit

class BorderButton: AppButton {

  static let kBorderWidth: CGFloat = 2.0 //* Constants.sizeAspect
  
  override var isEnabled: Bool {
    didSet {
      if isEnabled {
        setTitleColor(.accent, for: .normal)
        layer.borderColor = UIColor.accent.cgColor
        changeRightLabel(color: .accent)
      } else {
        setTitleColor(.minor, for: .normal)
        changeRightLabel(color: .minor)
        layer.borderColor = UIColor.minor.cgColor
      }
    }
  }
  
  
  override func applyStyle() {
    super.applyStyle()
    backgroundColor = .clear
    setTitleColor(.accent, for: .normal)
    layer.borderWidth = BorderButton.kBorderWidth
    layer.borderColor = UIColor.accent.cgColor
  }
  
  func fillLeftIcon(image: UIImage) {
    super.fillLeftIcon(image: image,
                       tintColor: .accent)
  }
  
  func fillRightLabel(text: String) {
      super.fillRightLabel(text: text,
                           textColor: .accent)
  }
  
  override func pressed() {
    let hsbAccent: HSB = UIColor.accent.getHSB()
    let pressedColor = UIColor.init(hue: hsbAccent.hue,
                                    saturation: hsbAccent.saturation * AppButton.kPressDeltaColorCoefficient,
                                    brightness: hsbAccent.brightness,
                                    alpha: hsbAccent.alpha)
    animationShowBorderColor(duration: AnimationSpeed.speed3.rawValue,
                             to: pressedColor.cgColor)
    UIView.transition(with: self,
                      duration: AnimationSpeed.speed3.rawValue,
                      options: .transitionCrossDissolve, animations: {
                        self.setTitleColor(pressedColor, for: .normal)
                        self.changeRightLabel(color: pressedColor)
    })
  }
  
  override func released() {
    animationShowBorderColor(duration: AnimationSpeed.speed3.rawValue,
                             to: UIColor.accent.cgColor)
    UIView.transition(with: self,
                      duration: AnimationSpeed.speed3.rawValue,
                      options: .transitionCrossDissolve, animations: {
                        self.setTitleColor(.accent, for: .normal)
                        self.changeRightLabel(color: .accent)
    })
  }
}
