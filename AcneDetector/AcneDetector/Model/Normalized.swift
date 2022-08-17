//
//  Normalized.swift
//  AcneDetector
//
//  Created by Nguyen Tran on 8/17/22.
//

import Foundation

struct Normalized: Codable {
    internal init(from: String, to: String) {
        self.from = from
        self.to = to
    }
    
  let from, to: String
}
