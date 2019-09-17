//
//  CALayer.swift
//  BestFitMe
//
//  Created by Титов Валентин on 18/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

extension CALayer {
  
  func animateTo(color: UIColor,
                 duration: TimeInterval) {
    let animation = CABasicAnimation(keyPath: BasicAnimationKey.borderColor.rawValue)
    animation.fromValue = borderColor
    animation.toValue = color.cgColor
    animation.duration = duration
    animation.repeatCount = 1
    borderColor = color.cgColor
    add(animation,
        forKey: BasicAnimationKey.borderColor.rawValue)
    
  }
  
  
}
