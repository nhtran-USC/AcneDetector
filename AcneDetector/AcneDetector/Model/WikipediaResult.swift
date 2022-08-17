//
//  WikipediaResult.swift
//  AcneDetector
//
//  Created by Nguyen Tran on 8/17/22.
//

import Foundation

struct WikiAPIResults: Codable {
    internal init(batchcomplete: String, query: Query) {
        self.batchcomplete = batchcomplete
        self.query = query
    }
  let batchcomplete: String
  let query: Query
}
