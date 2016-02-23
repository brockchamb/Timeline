//
//  Like.swift
//  Timeline
//
//  Created by admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct Like {
    var username: String
    var postIdentifier: String
    var identifier: String?
    
    init(username: String, postIdentifier: String, identifier: String?) {
        self.username = username
        self.postIdentifier = postIdentifier
        self.identifier = nil
    }
}

func ==(lhs: Like, rhs: Like) -> Bool {
    return lhs.username == rhs.username && lhs.postIdentifier == rhs.postIdentifier && lhs.identifier == rhs.identifier
}