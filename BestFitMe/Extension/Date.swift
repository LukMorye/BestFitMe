//
//  Date.swift
//  DemoKit
//
//  Created by Титов Валентин on 24.05.17.
//  Copyright © 2017 TrueNorth. All rights reserved.
//

import UIKit

private let kDateFormat = "dd.MM.yyyy, HH:mm"

extension Date {
  
  static let kDay: TimeInterval = 1.0
  static let kHoursInDay: TimeInterval = 24.0
  static let kMinInHour: TimeInterval = 60.0
  static let kSecInMin: TimeInterval = 60.0
  
  static func dateStringFrom(date:Date) -> String {
    let dateFormatter = DateFormatter.init()
    dateFormatter.dateFormat = kDateFormat
    let dateString = dateFormatter.string(from: date) as String
    return "\(dateString)"
  }
  
  static func dateStringFrom(timestamp:TimeInterval) -> String {
    return dateStringFrom(date: Date.init(timeIntervalSince1970: timestamp))
  }
  
  static func wholeNumbersOfDaysSince(timeInterval: TimeInterval) -> Int {
    let now: TimeInterval = Date().timeIntervalSince1970
    let seconds: TimeInterval  = now-timeInterval
    return Int(seconds/kSecInMin/kMinInHour/kHoursInDay)
  }
  
    
}
