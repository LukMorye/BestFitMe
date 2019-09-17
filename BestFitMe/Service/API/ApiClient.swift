//
//  ApiClient.swift
//  BestFitMe
//
//  Created by Титов Валентин on 16/07/2019.
//  Copyright © 2019 BestFitMe. All rights reserved.
//

import UIKit
import RxSwift

class ApiClient {
  
  enum StatusCode: Int {
    case success = 200
    case created = 201
    case defaulErrorCode = 400
    case sessionExpired = 401
    case forbidden = 403
    case resourceNotFound = 404
    case internalServerError = 500
  }
  
  private var baseURL: URL {
    get {
      switch Settings.shared.buildType {
      case .dev: return URL(string: "http://dev.link.ru")!
      case .qa: return URL(string: "https://qa.link.ru")!
      case .enterprise,.store:
        return (Settings.shared.market == .ru) ?
          URL(string: "https://link.ru")! :
          URL(string: "https://link.com")!
      }
    }
  }
  
  static var apiVersion: String = "v1"
  
  func send<T: Codable>(apiRequest: ApiRequest) -> Observable<T> {
    return Observable<T>.create { [unowned self] observer in
      let request = apiRequest.request(with: self.baseURL)
      let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
        if let err = error {
          observer.onError(err)
          return
        }
        do {
          guard let response: HTTPURLResponse = urlResponse as? HTTPURLResponse else {
            print("Error: URL Response is nil")
            return
          }
          let statusCode = response.statusCode
          switch (statusCode) {
          case StatusCode.success.rawValue, StatusCode.created.rawValue:
            try observer.onNext(JSONDecoder().decode(T.self, from: data ?? Data()))
          default:
            observer.onError(NSError.init(domain: Bundle.main.bundleIdentifier ?? .empty,
                                          code: statusCode,
                                          userInfo: ["Error" : data ?? "unknown error"]))
          }
        } catch let error {
          observer.onError(error)
        }
        observer.onCompleted()
      }
      task.resume()
      return Disposables.create {
        task.cancel()
      }
    }
  }
}
