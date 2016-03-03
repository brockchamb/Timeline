//
//  User.swift
//  Timeline
//
//  Created by admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation


struct User: Equatable, FirebaseType {
    
    private let kUsername = "username"
    private let kBio = "bio"
    private let kUrl = "url"
    
    var username = ""
    var bio: String?
    var url: String?
    var identifier: String?
    var endpoint: String {
        return "users"
    }
    
    var jsonValue: [String:AnyObject] {
        var json: [String:AnyObject] = [kUsername: username]
        
        if let bio = bio {
            json.updateValue(bio, forKey: kBio)
        }
        
        if let url = url {
            json.updateValue(url, forKey: kUrl)
        }
        return json
    }
    
    init?(json: [String : AnyObject], identifier: String) {
        guard let username = json[kUsername] as? String else {return nil}
        
        self.username = username
        self.bio = json[kBio] as? String
        self.url = json[kUrl] as? String
        self.identifier = identifier
        
    }
    
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