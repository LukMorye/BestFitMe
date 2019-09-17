//
//  NameField.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class NameField: AppField, TextFieldProtocol {
  /* Placeholder values */
  var placeHolderText: String = "Registration name placeholder".localized()
  var leftImage: UIImage = UIImage.typedImage(named: "ic_auth_name")!
  
  //MARK: Implementation
  override func applyStyle() {
    super.applyStyle()
    autocapitalizationType = .words
    keyboardType = .default
    setPlaceholder(icon: leftImage,
                   text: placeHolderText)
    returnKeyType = .next
    enablesReturnKeyAutomatically = true
  }

}
