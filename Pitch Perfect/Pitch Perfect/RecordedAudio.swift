//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Stefan Spaar on 3/19/15.
//  Copyright (c) 2015 Stefan Spaar. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    // Initialization introduced for project code optimization Task 1
    init(title: String, filePathUrl: NSURL) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}
