//
//  FieldsContainer.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class FieldsContainer: NibView, UITextFieldDelegate {
  /* UI Elements */
  @IBOutlet weak var nameField: NameField!
  @IBOutlet weak var phoneField: PhoneField!
  @IBOutlet weak var emailFIeld: LoginField!
  @IBOutlet weak var passwordField: PasswordField!
  
  
  //MARK: Implementation
  override func setup() {
    super.setup()
    nameField.delegate = self
    emailFIeld.delegate = self
    passwordField.delegate = self
  }
  
  func setDefaultFieldStates() {
    nameField.setBottomBorder(color: .nuance)
    phoneField.setBottomBorder(color: .nuance)
    emailFIeld.setBottomBorder(color: .nuance)
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
