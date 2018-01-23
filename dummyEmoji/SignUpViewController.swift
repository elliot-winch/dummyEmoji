//
//  SignUpViewController.swift
//  dummyEmoji
//
//  Created by Christopher Winch on 30/12/2017.
//  Copyright © 2017 Elliot Winch. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var username : String?
    private var password : String?
    
    
    @IBAction func wipeText(_ sender: UITextField) {
        sender.text = ""
    }
    
    @IBAction func checkUsername(_ sender: UITextField) {
            username = sender.text!
    }
    
    @IBAction func checkPassword(_ sender: UITextField) {
            password = sender.text!
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        
        if(username != nil && password != nil){
            Auth.auth().createUser(withEmail: username!, password: password!, completion: nil)
            
            Auth.auth().signIn(withEmail: self.username!, password: self.password!) { (user, error) in
                if(error != nil){
                    print("Sign In Error: " + error!.localizedDescription)
                }
            }
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
