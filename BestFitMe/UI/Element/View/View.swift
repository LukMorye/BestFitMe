//
//  View.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

class View: UIView {

  //MARK: Implementation
  override func awakeFromNib() {
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
    //        fatalError("This class does not support NSCoding")
    super.init(coder: aDecoder)
    applyStyle()
  }
  
  func applyStyle() {}

  func appear() {}
  
  func dissappear() {}
  
}
