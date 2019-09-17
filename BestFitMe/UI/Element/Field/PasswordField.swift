//
//  PasswordField.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class PasswordField: AppField {
  /* Placeholder values */
  var placeHolderText: String = "Registration password placeholder".localized()
  var leftImage: UIImage = UIImage.typedImage(named: "ic_auth_password")!
  
  //MARK: Implementation
  override func applyStyle() {
    super.applyStyle()
    keyboardType = .asciiCapable
    isSecureTextEntry = true
    setPlaceholder(icon: leftImage,
                   text: placeHolderText)
  }

}
