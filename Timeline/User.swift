//
//  User.swift
//  Timeline
//
//  Created by admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct User {
    var username: String
    var bio: String?
    var url: String?
    var identifier: String?
    
    init(username: String, bio: String?, url: String?, identifier: String?) {
        self.username = username
        self.bio = nil
        self.url = nil
        self.identifier = identifier

    }
    
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.username == rhs.username && lhs.identifier == rhs.identifier
    
}