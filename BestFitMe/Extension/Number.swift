//
//  Number.swift
//  BestfitQueue
//
//  Created by Титов Валентин on 25.05.2018.
//  Copyright © 2018 Valentin Titov. All rights reserved.
//

import UIKit

extension CGFloat {
  static var zero: CGFloat { get {return 0.0 }}
  var half:CGFloat { get { return self/2 } }
  var double:CGFloat  { get { return self*2 } }
  var toPercent: CGFloat { get { return self*100.0 } }
}

extension Float {
  var toPercent: Float { get { return self*100.0 } }
}

extension Double {
  static var zero: Double { get {return 0.0 }}
    var half:Double { get { return self/2 } }
    var double:Double  { get { return self*2 } }
}

extension Int {
  static var zero: Int { get {return 0 }}
  mutating func next() { self += 1 }
  mutating func increase() { self += 1 }
  mutating func previous() { self -= 1 }
  mutating func decrease() { self -= 1 }
}

struct Alpha {
    static let visible: CGFloat = 1.0
    static let invisible: CGFloat = 0.0
}


