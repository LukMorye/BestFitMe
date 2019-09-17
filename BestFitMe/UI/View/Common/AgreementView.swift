//
//  AgreementView.swift
//  BestFitMe
//
//  Created by Титов Валентин on 18/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class AgreementView: NibView {
  
  /* UI Elements */
  @IBOutlet weak var blurView: UIVisualEffectView!
  @IBOutlet weak var shadowView: UIView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var agreementTitleLabel: BoldLabel!
  @IBOutlet weak var agreementTextLabel: TextLabel!
  @IBOutlet weak var closeButton: UIButton!
  

  //MARK: Implementation
  override func setup() {
    super.setup()
    dissappear()
    blurView.contentView.showDefaultShadow()
    scrollView.layer.cornerRadius = Constants.corner
    closeButton.setImage(UIImage.typedImage(named: "ic_close_button"),
                         for: .normal)
  }
  
  func alignViewElements() {
    agreementTitleLabel.leadPinTo(gridRow: 1)
    agreementTitleLabel.trailPinTo(gridRow: 1)
    agreementTextLabel.leadPinTo(gridRow: 1)
    agreementTextLabel.trailPinTo(gridRow: 1)
  }
  
  func fillTitle(_ title: String) {
    agreementTitleLabel.text = title
  }
  
  func fillTextPlaceholder(_ placeholder: String) {
    agreementTextLabel.text = placeholder
    agreementTextLabel.textColor = .nuance
  }
  
  func fillText(_ text: String) {
    agreementTextLabel.text = text
    agreementTextLabel.textColor = .textPrimary
  }
  
  override func appear() {
    blurView.effect = UIBlurEffect(style: .light)
    scrollView.alpha = Alpha.visible
  }
  
  override func dissappear() {
    blurView.effect = nil
    scrollView.alpha = Alpha.invisible
  }
  
}
