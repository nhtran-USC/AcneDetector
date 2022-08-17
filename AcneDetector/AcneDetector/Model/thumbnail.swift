//
//  thumbnail.swift
//  AcneDetector
//
//  Created by Nguyen Tran on 8/17/22.
//

import Foundation
struct Thumbnail: Codable {
    internal init(source: String, width: Int, height: Int) {
        self.source = source
        self.width = width
        self.height = height
    }
    
    let source: String
    let width, height: Int
  }
