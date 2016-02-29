//
//  FirebaseController.swift
//  Timeline
//
//  Created by admin on 2/29/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import Firebase


class FirebaseController {
    static let base = Firebase(url: "timeline1224.firebaseIO.com")
    static let userRef = base.childByAppendingPath("User")
    
    static func dataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        
    }
}

