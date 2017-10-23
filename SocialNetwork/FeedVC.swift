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


class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func singOutPressed(_ sender: Any) {
        
        let keychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
        print("RL: ID removed from keychain  \(keychainResult)")
        try! Auth.auth().signOut()
        
        performSegue(withIdentifier: "backToSignIn", sender: nil)
        
        
        
    }

}
