//
//  file.swift
//  Pitch Perfect
//
//  Created by Savas Konstadinidis on 3/19/15.
//  Copyright (c) 2015 Savas Konstadinidis. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
var filePathUrl: NSURL!
  
var title: String!
  
init (filePathUrl: NSURL, title: String) {
    
self.filePathUrl = filePathUrl
self.title = title
  }
    
}
