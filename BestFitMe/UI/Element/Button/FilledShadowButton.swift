//
//  FilledShadowButton.swift
//  Job
//
//  Created by Титов Валентин on 25.12.2018.
//  Copyright © 2018 True North. All rights reserved.
//

import UIKit



class FilledShadowButton: FilledButton {
  /* Constants */
  private let kDefaultShadowSize: CGFloat = 15.0 * Constants.sizeAspect.rawValue
  private let kPressedShadowSize: CGFloat = 5.0 * Constants.sizeAspect.rawValue
  private let kPressingAnimationDuration: CFTimeInterval = 0.2
  var cornerRadius: CGFloat!
  
  
  
  /* Implementation */
  override func applyStyle() {
    super.applyStyle()
    showDefaultShadow()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    cornerRadius = frame.height.half
    layer.cornerRadius = cornerRadius
  }
  
  override func pressed() {
    super.pressed()
    animationChangeShadowRadius(to: kPressedShadowSize,
                                duration: kPressingAnimationDuration)
  }
  
  override func released() {
    super.released()
    animationChangeShadowRadius(to: kDefaultShadowSize,
                                duration: kPressingAnimationDuration)
    self.isUserInteractionEnabled = false
    DispatchQueue.main.asyncAfter(deadline: .now() + AnimationSpeed.speed1s.rawValue) {
      self.isUserInteractionEnabled = true
    }
  }
  
  
  
}
