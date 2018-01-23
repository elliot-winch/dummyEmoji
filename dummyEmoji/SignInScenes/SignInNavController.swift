//
//  SignInNavController.swift
//  dummyEmoji
//
//  Created by Elliot Richard John Winch on 1/23/18.
//  Copyright © 2018 Elliot Winch. All rights reserved.
//

import UIKit
import Firebase

class SignInNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func signIn(username: String, password: String){
        Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
            if(error != nil){
                print("Sign In Error: " + error!.localizedDescription)
            }
        }
        
        
    }

}
