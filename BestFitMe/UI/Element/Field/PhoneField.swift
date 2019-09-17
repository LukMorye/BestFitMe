//
//  PhoneField.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class PhoneField: AppField {

  var placeHolderText: String = "Registration phone placeholder".localized()
  var leftImage: UIImage = UIImage.typedImage(named: "ic_auth_phone")!
  
  override func applyStyle() {
    super.applyStyle()
    keyboardType = .phonePad
    setPlaceholder(icon: leftImage,
                   text: placeHolderText)
    returnKeyType = .next
    enablesReturnKeyAutomatically = true
  }

}
