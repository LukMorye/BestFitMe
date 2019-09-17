//
//  AppField.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class AppField: TextField {
  
  var clearButton = Button()
  private var inset: CGFloat { get { return 15.0 * Constants.sizeAspect.rawValue }}
  let border: CALayer = CALayer()
  private let borderThickness: CGFloat = 1.3 * Constants.sizeAspect.rawValue
  
  private final var leftViewWidth: CGFloat {
    get {
      if UIDevice.current.userInterfaceIdiom == .pad { return 25.0 }
      else { return 20.0 }
    }
  }
  
  //MARK: Implementation
  override func applyStyle() {
    super.applyStyle()
    textColor = .primary
    autocorrectionType = .no
    autocapitalizationType = .none
    placeBorder()
    rightViewMode = .always
  }
  
  func setPlaceholder(icon: UIImage,
                      text: String) {
    attributedPlaceholder = NSAttributedString(string: text,
                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    setLeft(image: icon)
    setRightButton()
  }

  
  private func placeBorder() {
    border.borderColor = UIColor.white.cgColor
    border.frame = CGRect(x: 0,
                          y: frame.size.height - borderThickness,
                          width:  frame.size.width,
                          height: frame.size.height)
    border.borderWidth = borderThickness
    layer.addSublayer(border)
    layer.masksToBounds = true
    setBottomBorder(color: .minor)
  }
  
  func setLeft(image:UIImage) {
    let size = image.size
    let leftView: UIButton = UIButton()
    leftView.setImage(image, for: .normal)
    leftView.isUserInteractionEnabled = false
    let padding: CGFloat = 10.0
    leftView.imageEdgeInsets = UIEdgeInsets.init(top: padding.half,
                                                 left: 0.0,
                                                 bottom: padding.half,
                                                 right: padding)
    let width = leftViewWidth + padding
    let height = (size.height/size.width) * width
    leftView.frame = CGRect.init(x: 0.0,
                                 y: 0.0,
                                 width: width,
                                 height: height)
    self.leftView = leftView
  }
  
  func setRightButton() {
    let image = UIImage.init(named: "ic_field_erase")!
    let size = image.size
    let clearButton: UIButton = UIButton()
    clearButton.setImage(image, for: .normal)
    
    let padding: CGFloat = 10.0
    clearButton.imageEdgeInsets = UIEdgeInsets.init(top: padding.half,
                                                    left: 0.0,
                                                    bottom: padding.half,
                                                    right: padding)
    let width = leftViewWidth + padding
    let height = (size.height/size.width) * width
    clearButton.frame = CGRect.init(x: 0.0,
                                    y: 0.0,
                                    width: width,
                                    height: height)
    clearButton.isHidden = true
    self.rightView = clearButton
  }
  
  func updateField(icon: UIImage) {
    if let leftView: UIButton = self.leftView as? UIButton {
      leftView.setImage(icon, for: .normal)
    }
  }
  
  func setBottomBorder(color: UIColor) {
    border.borderColor = color.cgColor
  }
  
}
