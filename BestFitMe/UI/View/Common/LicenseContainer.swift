//
//  LicenseContainer.swift
//  BestFitMe
//
//  Created by Титов Валентин on 17/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class LicenseContainer: NibView {
  /* Constants */
  static let kLicenseHeight: CGFloat = 45 * Constants.sizeAspect.rawValue
  /* UI Elements */
  @IBOutlet weak var agreeButton: UIButton!
  @IBOutlet weak var agreeLabel: SmallLabel!
  @IBOutlet weak var licenseButton: SmallSimpleButton!
  
  
  //MARK: Implementation
  func fill(agree: String,
            license: String) {
    agreeLabel.text = agree
    licenseButton.setTitle(license,
                           for: .normal)
  }
  

}
