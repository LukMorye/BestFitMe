//
//  UIView.swift
//  DemoPrototype
//
//  Created by Пригодич Станислав on 13/12/2017.
//  Copyright © 2017 True North. All rights reserved.
//

enum RowAttribute {
  case left, right
}

import UIKit

fileprivate let kAnimationBorderColorKey = "borderColor"
fileprivate let kAnimationShadowRadiusKey = "shadowRadius"
fileprivate let kAnimationCornerRadiusKey = "cornerRadius"
fileprivate let kShadowSize:CGFloat = 1.5
fileprivate let kOpacity:CGFloat = 0.4
fileprivate let kRadius:CGFloat = 15.0

fileprivate let kCardShadowSize:CGFloat = 3.0 * Constants.sizeAspect.rawValue
fileprivate let kCardShadowOpacity:CGFloat = 0.3 * Constants.sizeAspect.rawValue
fileprivate let kCardShadowRadius:CGFloat = 5.0 * Constants.sizeAspect.rawValue

extension UIView {
    
  func removeAllSubviews() {
    subviews.forEach{$0.removeFromSuperview()}
  }
}
  
//MARK: Grid system methods
extension UIView {
  
  func drawGrid() -> [UIView] {
    var grid:[UIView] = [UIView]()
    let rowCount: Int = Int(Constants.rowCount)
    var lastView: UIView!
    for number in 0..<rowCount {
      let rowView = defGridRowView()
      grid.append(rowView)
      if number == 0 {
        rowView.addPinEdgeToSameEdge(.left, toView: self,
                                     inset: Constants.offset)
      } else {
        rowView.addPinEdge(.left,
                           toEdge: .right,
                           toView: lastView,
                           inset: Constants.gutter)
      }
      lastView = rowView
    }
    return grid
  }
  
  func defGridRowView() -> UIView {
    let color = UIColor.init(red: 1.0,
                             green: 0.0,
                             blue: 0.0,
                             alpha: 0.1)
    let view: UIView = UIView.init(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(view)
    view.addWidth(Constants.rowWidth)
    view.addPinEdgesToSameEdgesOfSuperView([.top,.bottom])
    view.backgroundColor = color
    return view
  }
  
  func leadPinToHalfRow(includeOffset: Bool = true) {
    let leadPadding: CGFloat = (includeOffset ? Constants.offset : 0) + Constants.rowWidth.half
    addPinEdgeToSameEdge(.leading,
                         toView: superview!,
                         inset: leadPadding)
  }
  
  func leadPinTo(gridRow number: CGFloat,
                 includeOffset: Bool = true) {
    let leadPadding: CGFloat = (includeOffset ? Constants.offset : 0) +
      (number - 1.0) * Constants.rowWidth +
      (number - 1.0) * Constants.gutter
    addPinEdgeToSameEdge(.leading,
                         toView: superview!,
                         inset: leadPadding)
  }
  
  func trailPinToHalfRow(includeOffset: Bool = true) {
    let trailPadding: CGFloat = -(includeOffset ? Constants.offset : 0) - Constants.rowWidth.half
    addPinEdgeToSameEdge(.trailing,
                         toView: superview!,
                         inset: trailPadding)
  }
  
  func alignCenterXToLastRow(includeOffset: Bool = true) {
    let trailPadding: CGFloat = -(includeOffset ? Constants.offset : 0) - (Constants.rowWidth - intrinsicContentSize.width)/2
    addPinEdgeToSameEdge(.trailing,
                         toView: superview!,
                         inset: trailPadding)
  }
  
  func trailPinTo(gridRow number: CGFloat,
                  includeOffset: Bool = true) {
    let trailPadding: CGFloat = -(includeOffset ? Constants.offset : 0) -
      (number - 1.0) * Constants.rowWidth -
      (number - 1.0) * Constants.gutter
    addPinEdgeToSameEdge(.trailing,
                         toView: superview!,
                         inset: trailPadding)
  }
}
    //MARK: Autolayout methods
extension UIView {
    func resetElement() {
        translatesAutoresizingMaskIntoConstraints = false
        removeConstraints(constraints)
    }
    
    func addAllPinEdgesToSameEdgesOfSuperView() {
        addPinEdgesToSameEdgesOfSuperView([.top,.left,.bottom,.right],
                                          insets:.zero)
    }
    
    func addAllPinEdgesToSameEdgesOfSuperViewWithInsets(_ insets:UIEdgeInsets) {
        addPinEdgesToSameEdgesOfSuperView([.top,.left,.bottom,.right],
                                          insets:insets)
    }
    
    func addPinEdgesToSameEdgesOfSuperView(_ edges:UIRectEdge) {
        addPinEdgesToSameEdgesOfSuperView(edges,
                                          insets:.zero)
    }
    
    func addPinEdgesToSameEdgesOfSuperView(_ edges:UIRectEdge,
                                           insets:UIEdgeInsets) {
        if edges.contains(.top) {
            addPinEdge(.top,
                       toEdge: .top,
                       toView: superview!,
                       inset: insets.top,
                       relation: .equal)
        }
        if edges.contains(.left) {
            addPinEdge(.left,
                       toEdge: .left,
                       toView: superview!,
                       inset: insets.left,
                       relation: .equal)
        }
        if edges.contains(.bottom) {
            addPinEdge(.bottom,
                       toEdge: .bottom,
                       toView: superview!,
                       inset: insets.bottom,
                       relation: .equal)
            
        }
        if edges.contains(.right) {
            addPinEdge(.right,
                       toEdge: .right,
                       toView: superview!,
                       inset: insets.right,
                       relation: .equal)
        }
    }
    
    func addPinEdgesToSamesEdges(_ edges:UIRectEdge,
                                 for view:UIView) {
        if edges.contains(.top) {
            addPinEdgeToSameEdge(.top,
                                 for: view)
        }
        if edges.contains(.left) {
            addPinEdgeToSameEdge(.left,
                                 for: view)
        }
        if edges.contains(.bottom) {
            addPinEdgeToSameEdge(.bottom,
                                 for: view)
            
        }
        if edges.contains(.right) {
            addPinEdgeToSameEdge(.right,
                                 for: view)
        }
    }
    
    func addPinEdgeToSameEdge(_ edge:NSLayoutConstraint.Attribute,
                              for view:UIView) {
        NSLayoutConstraint(item: self,
                           attribute: edge,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: edge,
                           multiplier: 1.0,
                           constant: .zero).isActive = true
    }
    
    func addPinEdge(_ edge:NSLayoutConstraint.Attribute,
                    toEdge:NSLayoutConstraint.Attribute,
                    toView:UIView) {
        NSLayoutConstraint(item: self,
                           attribute: edge,
                           relatedBy: .equal,
                           toItem: toView,
                           attribute: toEdge,
                           multiplier: 1.0,
                           constant: .zero).isActive = true
    }
    
    func addPinEdge(_ edge:NSLayoutConstraint.Attribute,
                    toEdge:NSLayoutConstraint.Attribute,
                    toView:UIView,
                    inset:CGFloat) {
        addPinEdge(edge,
                   toEdge: toEdge,
                   toView: toView,
                   inset: inset,
                   relation: .equal)
    }
    
    func addPinEdgeToSameEdge(_ edge:NSLayoutConstraint.Attribute,
                              toView:UIView,
                              inset:CGFloat) {
        addPinEdge(edge,
                   toEdge: edge,
                   toView: toView,
                   inset: inset,
                   relation: .equal)
    }
    
    func addPinEdge(_ edge:NSLayoutConstraint.Attribute,
                    toEdge:NSLayoutConstraint.Attribute,
                    toView:UIView,
                    inset:CGFloat,
                    relation:NSLayoutConstraint.Relation) {
        NSLayoutConstraint(item: self,
                           attribute: edge,
                           relatedBy: relation,
                           toItem: toView,
                           attribute: toEdge,
                           multiplier: 1.0,
                           constant: inset).isActive = true
    }
    
    func addWidth(_ width:CGFloat) {
        addWidth(width, relation: .equal)
    }
    
    func addWidth(_ width:CGFloat,
                  relation:NSLayoutConstraint.Relation) {
        NSLayoutConstraint(item: self,
                           attribute: .width,
                           relatedBy: relation,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1.0,
                           constant: width).isActive = true
    }
    
    func addHeight(_ height:CGFloat) {
        addHeight(height, relation: .equal)
    }
    
    func addHeight(_ height:CGFloat,
                   relation:NSLayoutConstraint.Relation) {
        NSLayoutConstraint(item: self,
                           attribute: .height,
                           relatedBy: relation,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1.0,
                           constant: height).isActive = true
    }
    
    func changeSquare(from processedWidth:CGFloat,
                      processedHeight:CGFloat,
                      to targetHeight:CGFloat) {
        let aspect = processedWidth/processedHeight
        if let height = getConstraint(by: .height) {
            height.constant = targetHeight
        } else {
            addHeight(targetHeight)
        }
        if let width = getConstraint(by: .width) {
            width.constant = targetHeight * aspect
        } else {
            addWidth(targetHeight * aspect)
        }
    }
    
    func addAspectSquareBy(height:CGFloat) {
        let aspect = intrinsicContentSize.width/intrinsicContentSize.height
        addHeight(height)
        addWidth(height * aspect)
    }
    
    func addAspectSquareBy(width:CGFloat) {
        let aspect = intrinsicContentSize.height/intrinsicContentSize.width
        addWidth(width)
        addHeight(width * aspect)
    }
    
    func addSquare(side:CGFloat) {
        addWidth(side, relation: .equal)
        addHeight(side, relation: .equal)
    }
    
    func addSizeConstraints(for sourceSize:CGSize, newWidth:CGFloat) {
        let aspect = sourceSize.width/sourceSize.height
        addWidth(newWidth)
        addHeight(newWidth/aspect)
    }
    
    func addSizeConstraints(for sourceSize:CGSize, newHeight:CGFloat) {
        let aspect = sourceSize.width/sourceSize.height
        addWidth(newHeight)
        addHeight(newHeight * aspect)
    }
    
    func removeSizeConstraints() {
        var constraints = self.constraints
        for index in stride(from: constraints.count-1, to: 0, by: -1) {
            let constraint = constraints[index]
            if constraint.firstAttribute == .width || constraint.firstAttribute == .height {
                self.removeConstraint(constraint)
            }
        }
    }
    
    //MARK: Align on Axis methods
    func addAlignOnCenter() {
        addAlignOnAxisX()
        addAlignOnAxisY()
    }
    
    func addAlignOnAxisX() {
        addAlignOnAxisX(with: .zero)
    }
    
    func addAlignOnAxisX(with inset:CGFloat) {
        let attribute = NSLayoutConstraint.Attribute.centerX
        NSLayoutConstraint(item: self,
                           attribute: attribute,
                           relatedBy: .equal,
                           toItem: superview,
                           attribute: attribute,
                           multiplier: 1.0,
                           constant: inset).isActive = true
    }
    
    func addAlignOnAxisY() {
        addAlignOnAxisY(with: .zero)
    }
    
    func addAlignOnAxisY(with inset:CGFloat) {
        let attribute = NSLayoutConstraint.Attribute.centerY
        NSLayoutConstraint(item: self,
                           attribute: attribute,
                           relatedBy: .equal,
                           toItem: superview,
                           attribute: attribute,
                           multiplier: 1.0,
                           constant: inset).isActive = true
    }
    
    func addAllignXOnRelativeView(_ view:UIView) {
        let attribute = NSLayoutConstraint.Attribute.centerX
        NSLayoutConstraint(item: self,
                           attribute: attribute,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: attribute,
                           multiplier: 1.0,
                           constant: .zero).isActive = true
    }
    
    func addAllignYOnRelativeView(_ view:UIView) {
        let attribute = NSLayoutConstraint.Attribute.centerY
        NSLayoutConstraint(item: self,
                           attribute: attribute,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: attribute,
                           multiplier: 1.0,
                           constant: .zero).isActive = true
    }
    
    
    //MARK: Change sizes
    func changeSquare(side:CGFloat) {
        changeHeight(newHeight: side)
        changeWidth(newWidth: side)
    }
    
    func isExistHeightConstraint()  -> Bool {
        let constraints = self.constraints
        for constraint in constraints {
            if constraint.firstAttribute == .height {
                return true
            }
        }
        return false
    }
    
    func changeHeight(newHeight:CGFloat) {
      var isChanged: Bool = false
      let constraints = self.constraints
      for constraint in constraints {
        if constraint.firstAttribute == .height {
          constraint.constant = newHeight
          isChanged = true
        }
      }
      if !isChanged { addHeight(newHeight) }
    }
    
    func changeWidth(newWidth:CGFloat) {
        let constraints = self.constraints
        for constraint in constraints {
            if constraint.firstAttribute == .width {
                constraint.constant = newWidth
                return
            }
        }
    }
  
  func printConstrintConstants() {
    let constraints = self.constraints
    for constraint in constraints {
      print("Constraint attribute: \(constraint.firstAttribute). Constraint constant: \(constraint.constant)")
    }
  }
  
    func getConstraint(by attribute:NSLayoutConstraint.Attribute) -> NSLayoutConstraint?  {
        let constraints = self.constraints
        for constraint in constraints {
            if constraint.firstAttribute == attribute {
                return constraint
            }
        }
        return nil
    }
  
    //MARK: Transition
    func transitionWithDuration(duration:TimeInterval,
                                type:String,
                                direction:String) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = convertToCATransitionType(type)
        transition.subtype = convertToOptionalCATransitionSubtype(direction)
        layer.add(transition, forKey: nil)
    }
    
    //MARK: Animations
    /* Rotation */
    func rotateAnimation(duration: CFTimeInterval = 1.0) {
        isHidden = false
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.greatestFiniteMagnitude
        layer.add(rotateAnimation, forKey: nil)
    }
    
    /* Shadow radius */
    func animationChangeShadowRadius(to value: CGFloat,
                                     duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath:kAnimationShadowRadiusKey)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.fromValue = layer.shadowRadius
        animation.toValue = value
        animation.duration = duration
        layer.add(animation, forKey: kAnimationShadowRadiusKey)
        layer.shadowRadius = value
    }
    
    /* Border color */
    func animationShowBorderColor(duration: CFTimeInterval,
                                  to color: CGColor) {
        let animation = CABasicAnimation(keyPath:kAnimationBorderColorKey)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.fromValue = layer.borderColor
        animation.toValue = color
        animation.duration = duration
        layer.add(animation, forKey: kAnimationBorderColorKey)
        layer.borderColor = color
    }
    
    /* Change corner radius */
    func animateChangeCornerRadius(to value: CGFloat,
                                   duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath:kAnimationCornerRadiusKey)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.fromValue = layer.cornerRadius
        animation.toValue = value
        animation.duration = duration
        layer.add(animation, forKey: kAnimationCornerRadiusKey)
        layer.cornerRadius = value
    }
    
    func stopAndHide() {
        DispatchQueue.main.async {
            self.layer.removeAllAnimations()
            self.isHidden = true
        }
    }
  
  //MARK: UserInterfaceEnable
  func lock(with duration: TimeInterval) {
    isUserInteractionEnabled = false
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      self.isUserInteractionEnabled = true
    }
  }
  
    //MARK: Add visual effects
    /* Shadow */
  func showDefaultShadow() {
        showShadow(with: kShadowSize,
                   opacity: kOpacity,
                   radius: kRadius)
    }
  
  func showCardShadow() {
    showShadow(with: kCardShadowSize,
               opacity: kCardShadowOpacity,
               radius: kCardShadowRadius)
  }
    
    func showShadow(with size:CGFloat,
                    opacity:CGFloat,
                    radius:CGFloat,
                    color:CGColor = UIColor.black.cgColor) {
        layer.shadowColor = color
        layer.shadowOpacity = Float(opacity)
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize.init(width: 0.0,
                                         height: radius/2)
    }
  
  func hideShadow() {
    layer.shadowOpacity = 0.0
  }
  
    /* Gradient */
    func addVerticalGradient(from:CGPoint, to:CGPoint, colors:[CGColor]) {
        backgroundColor = .clear
        let gradient:CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors
        gradient.startPoint = from
        gradient.endPoint = to
        layer.insertSublayer(gradient, at: 0)
    }
    
    func removeGradient() {
        if let gradient = layer.sublayers?[0] as? CAGradientLayer {
            gradient.removeFromSuperlayer()
        }
    }
    
    /* Borders */
    @discardableResult func addBorders(edges: UIRectEdge,
                                       color: UIColor = .green,
                                       thickness: CGFloat = 1.0) -> [UIView] {
        var borders = [UIView]()
        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[top(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["top": top]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[top]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[left(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["left": left]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[left]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["right": right]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[right]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(0)-|",
                                               options: [],
                                               metrics: ["thickness": thickness],
                                               views: ["bottom": bottom]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottom]-(0)-|",
                                               options: [],
                                               metrics: nil,
                                               views: ["bottom": bottom]))
            borders.append(bottom)
        }
        return borders
    }
    
    func roundOut(with radius:CGFloat) {
        let roundPath: UIBezierPath = UIBezierPath.init(roundedRect: bounds,
                                                       cornerRadius: radius)
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.path = roundPath.cgPath
        layer.mask = maskLayer
    }
    
    /* Hole */
    func addHoleOverlay(radius: CGFloat,
                        color:UIColor) -> UIView {
        let overlayView = UIView.init(frame: CGRect.init(x: .zero,
                                                         y: .zero,
                                                         width: frame.width,
                                                         height: frame.height))
        overlayView.backgroundColor = color
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x: frame.width.half,
                                    y: frame.height.half),
                    radius: radius,
                    startAngle: .zero,
                    endAngle: 2.0 * CGFloat.pi,
                    clockwise: false)
        path.addRect(CGRect(x: .zero,
                            y: .zero,
                            width: overlayView.frame.width,
                            height: overlayView.frame.height))
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        addSubview(overlayView)
        return overlayView
    }
  
  
  
}

extension View {
  func shownWithDefaultAnimation(_ isShown: Bool,
                                 duration: TimeInterval) {
    if isShown { isHidden = false }
    UIView.animate(withDuration: duration,
                   animations: {
                    if isShown { self.appear() }
                    else { self.dissappear() }
    }) { (_) in
      if !isShown { self.isHidden = true }
    }
  }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToCATransitionType(_ input: String) -> CATransitionType {
	return CATransitionType(rawValue: input)
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalCATransitionSubtype(_ input: String?) -> CATransitionSubtype? {
	guard let input = input else { return nil }
	return CATransitionSubtype(rawValue: input)
}

extension UIView {
  
  func fadeTransition(_ duration:CFTimeInterval) {
    let animation = CATransition()
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    animation.type = CATransitionType.fade
    animation.duration = duration
    layer.add(animation,
              forKey: CATransitionType.fade.rawValue)
  }
  
  
}
