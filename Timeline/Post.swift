//
//  Post.swift
//  Timeline
//
//  Created by admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct Post: Equatable, FirebaseType {
    
    private let kUsername = "username"
    private let kImageEndpoint = "imageEndpoint"
    private let kCaption = "caption"
    private let kComments = "comments"
    private let kLikes = "likes"
    
    
    var imageEndpoint: String
    var caption: String?
    var username: String
    var comments: [Comment]
    var likes: [Like]
    var identifier: String?
    var endpoint: String {
        return "posts"
    }
    
    var jsonValue: [String:AnyObject] {
        var json: [String:AnyObject] = [kUsername: username, kImageEndpoint: imageEndpoint, kComments: comments.map({$0.jsonValue}), kLikes: likes.map({$0.jsonValue})]
        if let caption = caption {
            json.updateValue(caption, forKey: kCaption)
            
        }
        return json
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let imageEndpoint = json[kImageEndpoint] as? String,
              let username = json[kUsername] as? String else {return nil}
        self.imageEndpoint = imageEndpoint
        self.username = username
        self.caption = json[kCaption] as? String
        self.identifier = identifier
        
        if let commentDictionaries = json[kComments] as? [String:AnyObject] {
            self.comments = commentDictionaries.flatMap({Comment(json: $0.1 as! [String:AnyObject], identifier: $0.0)})
        } else {
            self.comments = []
        }
        if let likesDictionaries = json[kLikes] as? [String:AnyObject] {
            self.likes = likesDictionaries.flatMap({Like(json: $0.1 as! [String:AnyObject], identifier: $0.0)})
        } else {
            self.likes = []
        }
    }
    
    init(imageEndpoint: String, caption: String?, username: String, comments: [Comment], likes: [Like], identifier: String?) {
        self.imageEndpoint = imageEndpoint
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