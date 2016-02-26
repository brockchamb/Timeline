//
//  PostController.swift
//  Timeline
//
//  Created by admin on 2/23/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import UIKit


class PostController {
    
    static func fetchTimelineForUser(user: User, completion: (posts: [Post]?) -> Void) {
        completion(posts: mockPosts())
    }
    
    static func addPost(image: UIImage, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    static func postFromIdentifier(indentifier: String, completion: (post: Post?) -> Void) {
        completion(post: mockPosts().first)
    }
    
    static func postsForUser(user: User, completion: (post: [Post]?) -> Void) {
        completion(post: mockPosts())
    }
    
    static func deletePost(post: Post) {
        
    }
    
    static func addCommentWithTextPost(string: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: false, post: mockPosts().first)
    }
    
    static func addLikePost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: true, post: mockPosts().first)
    }
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        completion(success: false, post: mockPosts().first)
    }
    
    static func orderPosts(post: [Post]) -> [Timeline.Post] {
        return []
    }
    
    static func mockPosts() -> [Post] {
        let post1 = Post(imageEndPoint: "K1l4125TYvKMc7rcp5e", caption: "Nice!", username: "Brock", comments: [], likes: [], identifier: nil)
        let post2 = Post(imageEndPoint: "K1l4125TYvKMc7rcp5e", caption: nil, username: "Alex", comments: [], likes: [], identifier: nil)
        let post3 = Post(imageEndPoint: "K1l4125TYvKMc7rcp5e", caption: nil, username: "SammyB", comments: [], likes: [], identifier: nil)
        return [post1, post2, post3]
    }
    
    
    
        
}