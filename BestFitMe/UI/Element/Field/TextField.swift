//
//  TextField.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum TextFieldState {
  case empty, focused, done, error
}

protocol TextFieldProtocol {
  var placeHolderText: String { get }
  var leftImage: UIImage { get }
}

class TextField: UITextField {

  
  
  //MARK: Implementation
  override func awakeFromNib() {
    super.awakeFromNib()
    applyStyle()
  }
  
  convenience init () {
    self.init(frame:CGRect.zero)
  }
  
  override init (frame : CGRect) {
    super.init(frame : frame)
    applyStyle()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    applyStyle()
  }
  
  func applyStyle() {
    backgroundColor = .clear
    textColor = .primary
    font = .text
    clipsToBounds = true
    leftViewMode = .always
  }

  
  
}
