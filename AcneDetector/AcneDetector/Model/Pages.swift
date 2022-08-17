//
//  Pages.swift
//  AcneDetector
//
//  Created by Nguyen Tran on 8/17/22.
//

import Foundation

struct Pages: Codable {
    internal init(pageid: Int, ns: Int, title: String, thumbnail: Thumbnail?, extract: String, pageimage: String?) {
        self.pageid = pageid
        self.ns = ns
        self.title = title
        self.thumbnail = thumbnail
        self.extract = extract
        self.pageimage = pageimage
    }
    
    
  let pageid, ns: Int
  let title: String
  let thumbnail: Thumbnail?
    let extract: String
  let pageimage: String?
}
