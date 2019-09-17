//
//  ButtonsContainer.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class ButtonsContainer: NibView {
  /* UI Elements */
  @IBOutlet weak var registrationButton: FilledButton!
  @IBOutlet weak var authButton: UIButton!
  
  //MARK: Implementation
  func fill(regTitle: String,
            authTitle: String) {
    registrationButton.setTitle(regTitle, for: .normal)
    authButton.setTitle(authTitle, for: .normal)
  }
  

}
