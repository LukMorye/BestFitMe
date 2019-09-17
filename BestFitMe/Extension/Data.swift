//
//  DataExtension.swift
//  PhotoLoader
//
//  Created by Титов Валентин on 14.03.17.
//  Copyright © 2017 TrueNorth. All rights reserved.
//

import UIKit

extension Data {
    
    static func preparedUploadInfo(with info:[String:Any]) -> Data {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: info,
                                                      options: .prettyPrinted)
            return jsonData
        } catch  {
            print(error.localizedDescription)
        }
        return Data()
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8,
                               allowLossyConversion: true)
        append(data!)
    }
    
    var stringValue:String { get { return String.init(data: self as Data, encoding: .utf8) ?? "BAD CONVERTATING" }}
    
}

extension Data {
  static func asynchronusData(from url: URL,
                              completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
  }
  
  static func asynchronusDataFrom(request: URLRequest,
                              completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: request, completionHandler: completion).resume()
  }
  
}
