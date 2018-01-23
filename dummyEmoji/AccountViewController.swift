//
//  AccountViewController.swift
//  dummyEmoji
//
//  Created by Christopher Winch on 06/01/2018.
//  Copyright © 2018 Elliot Winch. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameText.text = Auth.auth().currentUser?.displayName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        print("Signing out")
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print(error)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
