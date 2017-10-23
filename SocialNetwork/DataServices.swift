//
//  DataServices.swift
//  SocialNetwork
//
//  Created by Ricardo Lousada on 23/10/17.
//  Copyright © 2017 IT-4-ALL. All rights reserved.
//

import Foundation
import Firebase

 let DB_REF = Database.database().reference()


class DataService {

    static let ds = DataService()
    
    private var _REF_BASE = DB_REF
    
    private var _REF_POSTS = DB_REF.child("posts")
    
    private var _REF_USERS = DB_REF.child("users")
    
    var REF_BASE: DatabaseReference {
    
        return _REF_BASE
    }
    
    var REF_POSTS: DatabaseReference {
    
    return _REF_POSTS
        
    }
    
    var REF_USERS: DatabaseReference {
    
        return _REF_USERS
    
    }
    
    func createFirebaseUser(uid: String, userdata: Dictionary <String, String>) {
    
        REF_USERS.child(uid).updateChildValues(userdata)
    
    }
    
    
    

}
