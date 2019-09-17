//
//  AppButton.swift
//  Job
//
//  Created by Титов Валентин on 15.02.2019.
//  Copyright © 2019 True North. All rights reserved.
//

import UIKit

class AppButton: Button {
  
  static let kPressDeltaColorCoefficient: CGFloat = 1.5
  
  /* Subviews */
  private var leftIcon: UIImageView?
  private var rightLabel: TextLabel?
  /* Constraints */
  private var leftIconConst: NSLayoutConstraint!
  private var rightLabelConst: NSLayoutConstraint!
  /* Params */
  private var cornerRadius: CGFloat!
  
  
  /* Implementation */
  override func applyStyle() {
    super.applyStyle()
    cornerRadius = Constants.viewHeight.half
    layer.cornerRadius = cornerRadius
    titleLabel?.font = .button
    addTarget(self, action: #selector(self.pressed), for: .touchDown)
    addTarget(self, action: #selector(self.released), for: .touchUpInside)
    addTarget(self, action: #selector(self.released), for: .touchUpOutside)
  }
  
  
  @objc func pressed() {}
  @objc func released() {}

}

//MARK: Left icon
extension AppButton {
  
  private func placeLeftIcon() {
    let leftIcon: UIImageView = UIImageView()
    addSubview(leftIcon)
    leftIcon.translatesAutoresizingMaskIntoConstraints = false
    leftIcon.addAlignOnAxisY()
    leftIconConst = NSLayoutConstraint.init(item: leftIcon,
                                            attribute: .leading,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .leading,
                                            multiplier: 1.0,
                                            constant: cornerRadius)
    leftIconConst.isActive = true
    leftIcon.alpha = Alpha.invisible
    layoutIfNeeded()
    self.leftIcon = leftIcon
  }
  
  func fillLeftIcon(image: UIImage,
                    tintColor: UIColor?) {
    if leftIcon == nil { placeLeftIcon() }
    if let color: UIColor = tintColor {
      leftIcon!.tint(image: image,
                    color: color)
    } else {
      leftIcon!.image = image
    }
    self.leftIcon!.alpha = Alpha.visible
  }

}


//MARK: Right label
extension AppButton {

  private func placeRightLabel() {
    let rightLabel: TextLabel = TextLabel()
    addSubview(rightLabel)
    rightLabel.translatesAutoresizingMaskIntoConstraints = false
    rightLabel.addAlignOnAxisY()
    rightLabelConst = NSLayoutConstraint.init(item: rightLabel,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .trailing,
                                              multiplier: 1.0,
                                              constant: -cornerRadius)
    rightLabel.textColor = .secondary
    rightLabel.textAlignment = .right
    rightLabel.alpha = Alpha.invisible
    self.rightLabel = rightLabel
  }
  
  func defineRightLabelText(color: UIColor) {}
  
  
  
  func fillRightLabel(text: String,
                      textColor: UIColor = UIColor.accent) {
    if rightLabel == nil { placeRightLabel() }
    rightLabel!.text = text
    rightLabelConst.constant = -cornerRadius
    rightLabelConst.isActive = true
    rightLabel!.textColor = textColor
    layoutIfNeeded()
    UIView.animate(withDuration: AnimationSpeed.speed3.rawValue) {
      self.rightLabel!.alpha = Alpha.visible
    }
  }
  
  func changeRightLabel(color: UIColor) {
    rightLabel?.textColor = color
  }

}
