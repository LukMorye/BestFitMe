//
//  NibView.swift
//  DemoPrototype
//
//  Created by Пригодич Станислав on 21/12/2017.
//  Copyright © 2017 True North. All rights reserved.
//


import UIKit

class NibView: View {
    
  var contentView: UIView!
  
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
  }
  
  override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
  }
    
  func setup() {
    translatesAutoresizingMaskIntoConstraints = false
    guard let contentView: UIView = Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                                             owner: self,
                                                             options: [:])?.first as? UIView else { return }
    contentView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(contentView)
    for constraintFormat in ["V:|[contentView]|", "H:|[contentView]|"] {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraintFormat, options: [], metrics: nil, views: ["contentView": contentView]))
    }
    self.contentView = contentView
    applyNibStyle()
  }
  
  func applyNibStyle() {
    
  }
  
 
    
}
