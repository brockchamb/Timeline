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
        UserController.followedByUser(user) { (followed) in
            var allPosts: [Post] = []
            let dispatchGroup = dispatch_group_create()
            
            dispatch_group_enter(dispatchGroup)
            postsForUser(UserController.sharedController.currentUser, completion: { (posts) -> Void in
                if let posts = posts {
                    allPosts += posts
                }
                dispatch_group_leave(dispatchGroup)
         })
            if let followed = followed {
                for user in followed {
                    
                    dispatch_group_enter(dispatchGroup)
                    postsForUser(user, completion: { (posts) in
                        if let posts = posts {
                            allPosts += posts
                        }
                        dispatch_group_leave(dispatchGroup)
                    })
                }
            }
            dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), { () in
                let orderedPosts = orderPosts(allPosts)
                completion(posts: orderedPosts)
            })
        }
    }
    
    static func addPost(image: UIImage, caption: String?, completion: (success: Bool, post: Post?) -> Void) {
        ImageController.uploadImage(image) { (identifier) -> Void in
            if let identifier = identifier {
                var post = Post(imageEndpoint: identifier, caption: caption, username: UserController.sharedController.currentUser.username, comments: [], likes: [], identifier: nil)
                post.save()
                completion(success: true, post: post)
            } else {
                completion(success: false, post: nil)
            }
        }
    }
    
    static func postFromIdentifier(identifier: String, completion: (post: Post?) -> Void) {
        FirebaseController.dataAtEndpoint("posts/\(identifier)") { (data) -> Void in
            if let data = data as? [String:AnyObject] {
                let post = Post(json: data, identifier: identifier)
                completion(post: post)
            } else {
                completion(post: nil)
            }
        }
    }
    
    static func postsForUser(user: User, completion: (post: [Post]?) -> Void) {
        FirebaseController.base.childByAppendingPath("posts").queryOrderedByChild("username").queryEqualToValue(user.username).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if let postDictionaries = snapshot.value as? [String:AnyObject] {
                let posts = postDictionaries.flatMap({Post(json: $0.1 as! [String:AnyObject], identifier: $0.0)})
                let orderedPosts = orderPosts(posts)
                completion(post: orderedPosts)
            } else {
                completion(post: nil)
            }
        
        })
    }
    
    static func deletePost(post: Post) {
        post.delete()
    }
    
    static func addCommentWithTextPost(string: String, post: Post, completion: (success: Bool, post: Post?) -> Void) {
        if let postIdentifier = post.identifier {
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: "text", postIdentifier: postIdentifier)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
                completion(success: true, post: post)
            }
        } else {
            var post = post
            post.save()
            var comment = Comment(username: UserController.sharedController.currentUser.username, text: "text", postIdentifier: post.identifier!)
            comment.save()
            
            PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
                completion(success: true, post: post)
            }
        }

    }
    
    static func deleteComment(comment: Comment, completion: (success: Bool, post: Post?) -> Void) {
        comment.delete()
        PostController.postFromIdentifier(comment.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    static func addLikePost(post: Post, completion: (success: Bool, post: Post?) -> Void) {
        if let postIdentifier = post.identifier {
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: postIdentifier)
            like.save()
        } else {
            var post = post
            post.save()
            var like = Like(username: UserController.sharedController.currentUser.username, postIdentifier: post.identifier!)
            like.save()
        }
        PostController.postFromIdentifier(post.identifier!) { (post) -> Void in
            completion(success: true, post: post)
        }
    }
    
    static func deleteLike(like: Like, completion: (success: Bool, post: Post?) -> Void) {
        like.delete()
        PostController.postFromIdentifier(like.postIdentifier) { (post) -> Void in
            completion(success: true, post: post)
        }
        
    }
    
    static func orderPosts(post: [Post]) -> [Timeline.Post] {
        return post.sort({$0.0.identifier > $0.1.identifier})
    }
    
//    static func mockPosts() -> [Post] {
//        let post1 = Post(imageEndpoint: "K1l4125TYvKMc7rcp5e", caption: "Nice!", username: "Brock", comments: [], likes: [], identifier: nil)
//        let post2 = Post(imageEndpoint: "K1l4125TYvKMc7rcp5e", caption: nil, username: "Alex", comments: [], likes: [], identifier: nil)
//        let post3 = Post(imageEndpoint: "K1l4125TYvKMc7rcp5e", caption: nil, username: "SammyB", comments: [], likes: [], identifier: nil)
//        return [post1, post2, post3]
//    }
    
    
    
        
}