//
//  Post.swift
//  SocialNetwork
//
//  Created by Ricardo Lousada on 24/10/17.
//  Copyright © 2017 IT-4-ALL. All rights reserved.
//

import Foundation


class Post {

    private var _caption: String!
    private var _imageURL: String!
    private var _postKey: String!
    private var _likes: Int!
    
    var caption: String {
    
        return _caption
    }

    
    var imageURL: String {
    
        return _imageURL
    }
    
    var postKey: String {
    
        return _postKey
    }
    
    var likes: Int {
    
        return _likes
    }
    
    init(caption: String, imageURL: String, likes: Int) {
    
        self._caption = caption
        self._imageURL = imageURL
        self._likes = likes
    }
    
    init(postKey: String, postData: Dictionary<String,AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] {
            self._caption = caption as? String
        }
        if let imageURL = postData["imageURL"] {
            self._imageURL = imageURL as? String
        }
        if let likes = postData["likes"] {
            self._likes = likes as? Int
        }

    }

}
