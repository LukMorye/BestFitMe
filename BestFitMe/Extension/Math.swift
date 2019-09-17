//
//  Math.swift
//  HR_MVP
//
//  Created by Титов Валентин on 25.04.2018.
//  Copyright © 2018 Valentin Titov. All rights reserved.
//

import UIKit

class Math {

    static func iPow2(value:Int) -> Int {
        return value * value
    }
}

func += <K, V> (left: inout [K:V], right: [K:V]) {
  for (k, v) in right {
    left[k] = v
  }
}
