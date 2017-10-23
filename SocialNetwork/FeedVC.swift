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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
        func numberOfSection(in tableView: UITableView) -> Int {
        
            return 1
        
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return 3
            
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        
        }
        

    @IBAction func singOutPressed(_ sender: Any) {
        
        let keychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
        print("RL: ID removed from keychain  \(keychainResult)")
        try! Auth.auth().signOut()
        
        performSegue(withIdentifier: "backToSignIn", sender: nil)
        
    }

}
