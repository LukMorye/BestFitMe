//
//  LoginField.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class LoginField: AppField {
  /* Placeholder values */
  var placeHolderText: String = "Registration email placeholder".localized()
  var leftImage: UIImage = UIImage.typedImage(named: "ic_auth_email")!
  
  //MARK: Implementation
  override func applyStyle() {
    super.applyStyle()
    keyboardType = .emailAddress
    setPlaceholder(icon: leftImage,
                   text: placeHolderText)
    returnKeyType = .next
    enablesReturnKeyAutomatically = true
  }

}
