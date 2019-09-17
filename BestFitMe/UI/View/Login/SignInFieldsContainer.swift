//
//  SignInFieldsContainer.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class SignInFieldsContainer: NibView, UITextFieldDelegate {
  /* UI Elements */
  @IBOutlet weak var emailField: LoginField!
  @IBOutlet weak var passwordField: PasswordField!

  
  //MARK: Implementation
  override func setup() {
    super.setup()
    emailField.delegate = self
    passwordField.delegate = self
  }
  
  func setDefaultFieldStates() {
    emailField.setBottomBorder(color: .nuance)
    passwordField.setBottomBorder(color: .nuance)
  }
  
  func focusOnField(field:AppField) {
    field.setBottomBorder(color: .primary)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let nextTag = textField.tag + 1
    if let nextResponder = viewWithTag(nextTag) {
      nextResponder.becomeFirstResponder()
    } else {
      textField.resignFirstResponder()
    }
    return false
  }

}
