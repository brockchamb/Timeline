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
    
    static func dataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let baseForEndpoint = FirebaseController.base.childByAppendingPath(endpoint)
        baseForEndpoint.observeSingleEventOfType(.Value, withBlock: { snap in
            if snap.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snap.value)
            }
        })
   }
    
    static func observeDataAtEndpoint(endpoint: String, completion: (data: AnyObject?) -> Void) {
        let baseForEndPoint = FirebaseController.base.childByAppendingPath(endpoint)
        baseForEndPoint.observeSingleEventOfType(.Value, withBlock: { snap in
            if snap.value is NSNull {
                completion(data: nil)
            } else {
                completion(data: snap.value)
            }
        })

    }
}

protocol FirebaseType {
    var identifier: String? {get set}
    var endpoint: String {get}
    var jsonValue: [String:AnyObject] {get}
    
    init?(json: [String:AnyObject], identifier: String)
    
    mutating func save()
    func delete()

}

extension FirebaseType {
    mutating func save() {
        var endpointBase: Firebase
        if let identifier = self.identifier {
            endpointBase = FirebaseController.base.childByAppendingPath(endpoint).childByAppendingPath(identifier)
        } else {
            endpointBase = FirebaseController.base.childByAppendingPath(endpoint).childByAutoId()
            self.identifier = endpointBase.key
        }
        endpointBase.updateChildValues(self.jsonValue)
    }
    
    func delete() {
        if let identifier = self.identifier {
            let endpointBase: Firebase = FirebaseController.base.childByAppendingPath(endpoint).childByAppendingPath(identifier)
            endpointBase.removeValue()
        }
    }
}
















