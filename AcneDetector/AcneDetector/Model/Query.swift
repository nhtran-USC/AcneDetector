//
//  Query.swift
//  AcneDetector
//
//  Created by Nguyen Tran on 8/17/22.
//

import Foundation

struct Query: Codable {
    internal init(normalized: [Normalized], pages: [String : Pages], pageids: [String]) {
        self.normalized = normalized
        self.pages = pages
        self.pageids = pageids
    }
    
  let normalized: [Normalized]
  let pages: [String:Pages]
    let pageids: [String]
}
