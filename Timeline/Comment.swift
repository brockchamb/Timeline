//
//  Comment.swift
//  Timeline
//
//  Created by admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

struct Comment {
    var username: String
    var text: String
    var postIdentifier: String
    var identifier: String?
    
    init(username: String, text: String, postIdentifier: String, identifier: String?) {
        self.username = username
        self.text = text
        self.postIdentifier = postIdentifier
        self.identifier = nil
    }
}

func ==(lhs: Comment, rhs: Comment) -> Bool {
    return lhs.username == rhs.username && lhs.postIdentifier == rhs.postIdentifier && lhs.identifier == rhs.identifier
}
