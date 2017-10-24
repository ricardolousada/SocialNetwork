//
//  FeedVC.swift
//  SocialNetwork
//
//  Created by Ricardo Lousada on 23/10/17.
//  Copyright © 2017 IT-4-ALL. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase


class FeedVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            self.posts=[]
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                print("RL: estes são os posts existentes: \(snapshot)")
                
                for snap in snapshot {
                    print("RL: SNAP: \(snap)")
                    if let postDict = snap.value as? Dictionary<String,AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                    
                }
                
            }
            self.tableView.reloadData()
        })
        
        
    }
    
        func numberOfSection(in tableView: UITableView) -> Int {
        
            return 1
        
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        
            return posts.count
            
        }
        
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.configureCell(post: post)
            return cell
            
        } else {
            return PostCell()
        }
    }
    

    @IBAction func singOutPressed(_ sender: Any) {
        
        let keychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
        print("RL: ID removed from keychain  \(keychainResult)")
        try! Auth.auth().signOut()
        
        performSegue(withIdentifier: "backToSignIn", sender: nil)
        
    }

}
