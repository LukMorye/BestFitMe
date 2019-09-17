//
//  StringExtension.swift
//  SalesUp_SM
//
//  Created by Титов Валентин on 06.03.17.
//  Copyright © 2017 TrueNorth. All rights reserved.
//

import UIKit

extension String {
    
    static var empty:String { return "" }
    static var space:String { return " " }
    static var equal:String { return "=" }
    static var colon:String { return ":" }
    static var semicolon:String { return ";" }
    static var quote:String { return "\"" }
    static var null:String { return "nil" }
    static var newLine:String { return "\n" }
    static var endLine:String { return "\r\n" }
    static var slash:String { return "/" }
    static var boundaryString: String {
        return "----Mobile-iOS-\(UUID().uuidString)"
    }
  
  //MARK: Validate fields
  static func isEmpty(text: String?) -> Bool {
    if text == nil { return true }
    return text!.withoutSpaces() == .empty
  }
    
  func withoutSpaces() -> String {
      return self.trimmingCharacters(in: .whitespaces)
  }
  
  func capitalizingFirstLetter() -> String {
    return prefix(1).uppercased() + self.lowercased().dropFirst()
  }
  
  func localized() -> String {
      return NSLocalizedString(self, comment: String.empty)
  }
  
  func URLEncoded() -> String {
      let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@-._"
      let unreservedCharset = NSCharacterSet(charactersIn: unreservedChars)
      let encodedString = addingPercentEncoding(withAllowedCharacters: unreservedCharset as CharacterSet)
      return encodedString ?? self
  }
  
  func isValidEmail() -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
      let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      return emailTest.evaluate(with: self)
  }
  
  func isValidPhone() -> Bool {
    let charcter  = NSCharacterSet(charactersIn: "+-()0123456789").inverted
    var filtered:String!
    let inputString:NSArray = self.components(separatedBy: charcter) as NSArray
    filtered = inputString.componentsJoined(by: "")
    return  self == filtered
  }

  static func unwrapped(value:Any?) -> String {
      if let string = value as? String { return string }
      if let number = value as? NSNumber { return number.stringValue }
      if let image = value as? UIImage { return image.description }
      return .null
  }
  
  static func httpBodyString(from headerPart:[String:String], bodyPart: [[String:String]]) -> String {
      let string = NSMutableString()
      for (header,value) in headerPart {
          string.append(header)
          string.append(.colon)
          string.append(.space)
          string.append(value)
      }
      for param in bodyPart {
          for (key,value) in param {
              string.append(.semicolon)
              string.append(.space)
              string.append(key)
              string.append(.equal)
              string.append(.quote)
              string.append(value)
              string.append(.quote)
          }
      }
      string.append(.semicolon)
      string.append(.endLine)
      return string as String
  }
    
}
