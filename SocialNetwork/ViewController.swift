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
import SwiftKeychainWrapper


class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: FancyField!
    
    @IBOutlet weak var passwordField: FancyField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //checks if the key is already in the keychain, if yes skips login and goes to the feedVC
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("RL: ID found in Keychain")
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
        
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
                if let user = user {
                    let userData = ["provider":credential.provider]
                    self.completeSignIn(id: user.uid,userData: userData)
                    
                }
            }
        })
        
    }
    
    
    @IBAction func signInPressed(_ sender: Any) {
        
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("RL:User, \(email) authenticated ")
                    let userData = ["provider": user?.providerID]
                    self.completeSignIn(id: (user?.uid)!,userData: userData as! Dictionary<String, String>
                    )
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: {(user,error) in
                        if error != nil {
                            print("RL:Unable to authenticate in Firebase using email: \(email),error: \(error)")
                        } else {
                            print("RL: Sucessfully authenticated with Firebase")
                            let userData = ["provider": user?.providerID]
                            self.completeSignIn(id: (user?.uid)!,userData: userData as! Dictionary<String, String>)
                        }
                    })
                }
            })
        }
    }
 
    func completeSignIn(id:String, userData: Dictionary<String,String>) {
        print("RL:\(id), \(userData)")
        DataService.ds.createFirebaseUser(uid: id, userdata: userData )
        let keychainResult = KeychainWrapper.standard.set(id, forKey:KEY_UID)
        print("RL: Data saved to keychain for user: \(id), \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
        
    }
    
    
}

