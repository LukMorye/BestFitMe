//
//  CompleteRegistrationView.swift
//  BestFitMe
//
//  Created by Титов Валентин on 29/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class CompleteRegistrationView: NibView {
  
  // UI Elements
  @IBOutlet weak var alertContainer: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var detailsLabel: UILabel!
  @IBOutlet weak var separator: UIView!
  @IBOutlet weak var buttonContainer: UIView!
  @IBOutlet weak var nextButton: FilledButton!
  @IBOutlet weak var nextLabel: UILabel!
  
  
  //MARK: Implementation
  override func applyNibStyle() {
    titleLabel.textAlignment = .center
    detailsLabel.textAlignment = .center
    nextButton.layer.cornerRadius = 0.0
    alertContainer.layer.cornerRadius = Constants.corner
  }
  
  func alignElementsFor(device: UIUserInterfaceIdiom) {
    if device == .pad {
      alertContainer.leadPinTo(gridRow: 2)
      alertContainer.trailPinTo(gridRow: 2)
      titleLabel.leadPinTo(gridRow: 2)
      titleLabel.trailPinTo(gridRow: 2)
      detailsLabel.leadPinTo(gridRow: 2)
      detailsLabel.trailPinTo(gridRow: 2)
    } else {
      alertContainer.leadPinToHalfRow()
      alertContainer.trailPinToHalfRow()
      titleLabel.leadPinToHalfRow()
      titleLabel.trailPinToHalfRow()
      detailsLabel.leadPinToHalfRow()
      detailsLabel.trailPinToHalfRow()
    }
    titleLabel.addPinEdgeToSameEdge(.top, toView: alertContainer, inset: Constants.offset)
    buttonContainer.changeHeight(newHeight: Constants.viewHeight)
    
  }
  
  override func appear() {
    alpha = Alpha.visible
  }
  
  override func dissappear() {
    alpha = Alpha.invisible
  }
  
  func fill(title: String,
            details: String,
            nextTitle: String) {
    titleLabel.text = title
    detailsLabel.text = details
    nextLabel.text = nextTitle
  }
  
  
}
