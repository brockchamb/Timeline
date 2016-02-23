//
//  Post.swift
//  Timeline
//
//  Created by admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct Post {
    var imageEndPoint: String
    var caption: String?
    var username: String
    var comments: [Comment]
    var likes: [Like]
    var identifier: String?
    
    init(imageEndPoint: String, caption: String?, username: String, comments: [Comment], likes: [Like], identifier: String?) {
        self.imageEndPoint = imageEndPoint
        self.caption = nil
        self.username = username
        self.comments = comments
        self.likes = likes
        self.identifier = nil
    }
}

func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.username == rhs.username && lhs.identifier == rhs.identifier
}