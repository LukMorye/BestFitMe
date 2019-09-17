//
//  ApiRequest.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit

enum HttpHeader: String {
  case contentType = "Content-Type",
  authorization = "Authorization",
  userAgent = "User-Agent",
  cacheControl = "Cache-Control"
}

enum ContentType: String {
  case simpleUTF8 = "application/x-www-form-urlencoded"
  case json = "application/json"
  case image = "image/jpeg"
  case multipart = "multipart/form-data;"
}

enum RequestType: String {
  case get, post, put, delete, patch
}



protocol ApiRequest {
  var method: RequestType { get }
  var contentType: ContentType { get }
  
  var path: String { get }
  var isBody: Bool { get }
  var parameters: [String : Any]? { get }
  var binaryData:Data? { get }
}

extension ApiRequest {
  func request(with baseURL: URL) -> URLRequest {
    guard var components = URLComponents(url: baseURL.appendingPathComponent(path),
                                         resolvingAgainstBaseURL: false) else {
                                          fatalError("Unable to create URL components")
    }
    var body:Data?
    if isBody,
      let parameters:[String: Any] = self.parameters {
      do {
        body = try JSONSerialization.data(withJSONObject: parameters,
                                          options: .prettyPrinted)
      } catch {
        print("Can't serialization parameters with tyoe [String:Any]")
      }
    } else {
      components.queryItems = parameters?.compactMap({ (key,value) -> URLQueryItem in
        URLQueryItem(name: key, value: value as? String ?? "")
      })
    }
    guard let url = components.url else {
      fatalError("Could not get url")
    }
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    request.addValue(contentType.rawValue,
                     forHTTPHeaderField: HttpHeader.contentType.rawValue)
    request.addValue(userAgent(),
                     forHTTPHeaderField: HttpHeader.userAgent.rawValue)
    if binaryData != nil {
      request.httpBody = binaryData
    } else {
      request.httpBody = body
    }
    
    return request
  }
}

func userAgent() -> String {
  guard let info = Bundle.main.infoDictionary,
    let appName = info["CFBundleName"] as? String,
    let bundleVersion = (info["CFBundleShortVersionString"] as? String)
    else { return String.empty }
  return "\(appName) v\(bundleVersion)"
}

func boundary() -> String {
  let device:UIDevice = UIDevice.current
  return "boundary=----------Apple-iOS-\(device.systemVersion)-----\(device.identifierForVendor!) "
}
