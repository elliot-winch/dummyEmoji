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
        if username != nil && password != nil{
        
            if let signInNavCont = self.navigationController as? SignInNavController{
                signInNavCont.signIn(username: username!, password: password!)
            }
        }
    }
}
