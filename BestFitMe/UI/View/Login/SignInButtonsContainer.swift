//
//  ButtonsContainer.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class SignInButtonsContainer: NibView {
  
  /* UI Elements */
  @IBOutlet weak var signInButton: FilledButton!
  @IBOutlet weak var signUpButton: SimpleButton!
  
  
  //MARK: Implementation
  func fill(authTitle: String,
            regTitle: String) {
    signInButton.setTitle(authTitle,
                          for: .normal)
    signUpButton.setTitle(regTitle,
                          for: .normal)
    
  }
  

}
