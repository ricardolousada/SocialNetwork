//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Ricardo Lousada on 22/10/17.
//  Copyright © 2017 IT-4-ALL. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("RL:Unable to autenticate with facebook - \(error)")
            } else if result?.isCancelled == true {
                print("RL: User canceled facebook authentication")
            } else {
                print ("RL: Successfully authentication with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuthentication(credential)
            }
        }
        
    }

    func firebaseAuthentication(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("RL: Unable to auth with firebase")
                
            } else {
                print("RL: Sucessfully auth with Firebase")
            }
        })
        
    }
    
}

