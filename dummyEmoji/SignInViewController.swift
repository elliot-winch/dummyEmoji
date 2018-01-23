//
//  SignInViewController.swift
//  dummyEmoji
//
//  Created by Christopher Winch on 30/12/2017.
//  Copyright © 2017 Elliot Winch. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    private var username : String?
    private var password : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func wipeText(_ sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func checkUsername(_ sender: UITextField) {
            username = sender.text!
    }
    
    @IBAction func checkPassword(_ sender: UITextField) {
            password = sender.text!
    }
    
    @IBAction func signIn(_ sender: Any) {
        if(username != nil && password != nil){
            
            Auth.auth().signIn(withEmail: self.username!, password: self.password!) { (user, error) in
                if(error != nil){
                    print("Sign In Error: " + error!.localizedDescription)
                }
            }
        } else {
            print("Username or password are nil")
        }
    }
}
