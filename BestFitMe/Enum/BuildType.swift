//
//  BuildType.swift
//  BestFitMe
//
//  Created by Титов Валентин on 05.04.2018.
//  Copyright © 2018 Valentin Titov. All rights reserved.
//

import UIKit

enum BuildType:String {
  
  case dev,qa,enterprise,store
    
    func folderName() -> String {
        switch self {
        case .dev: return "dev_bestfit_job"
        case .qa: return "qa_bestfit_job3"
        case .enterprise:
          switch Settings.shared.market {
          case .ru: return "bestfit_job3"
          case .eu: return "install"
          }
        case .store: return .empty
        }
    }
}
