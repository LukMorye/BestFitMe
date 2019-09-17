//
//  TopView.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class TopView: NibView {

  /* UI Elements */
  @IBOutlet weak var logoView: UIImageView!
  @IBOutlet weak var menuButton: UIButton!
  @IBOutlet weak var progress: UIActivityIndicatorView!
  @IBOutlet weak var errorLabel: UILabel!
  
  
  //MARK: Implementation
  func showMenuButton() {
    menuButton.isHidden = false
  }
  
  func hideMenuButton() {
    menuButton.isHidden = true
  }
  
  func setMenuButton(alpha: CGFloat) {
    menuButton.alpha = alpha
  }
  
  func startProgress() {
    progress.startAnimating()
  }
  
  func stopProgress() {
    progress.stopAnimating()
  }
  
  func fillError(message: String?) {
    errorLabel.text = message
  }
  
}
