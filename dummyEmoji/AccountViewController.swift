//
//  AccountViewController.swift
//  dummyEmoji
//
//  Created by Christopher Winch on 06/01/2018.
//  Copyright © 2018 Elliot Winch. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AccountViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var favColorImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(Auth.auth().currentUser != nil) {
            let currentUser = Auth.auth().currentUser!
            
            usernameText.text = currentUser.email
            
            changeFavColorImageFromDatabase()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        changeFavColorImageFromDatabase()
    }
    
    func changeFavColorImageFromDatabase(){
        let currentUser = Auth.auth().currentUser!

        let userRef = Database.database().reference().child("users/\(currentUser.uid)/favColor")
        
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let redVal = snapshot.childSnapshot(forPath: "r").value as! CGFloat / 256.0
            let greenVal = snapshot.childSnapshot(forPath: "g").value as! CGFloat / 256.0
            let blueVal = snapshot.childSnapshot(forPath: "b").value as! CGFloat / 256.0
            
             self.favColorImage.backgroundColor = UIColor(red: redVal, green: greenVal, blue: blueVal, alpha: CGFloat(1))
 
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        //move to navigation controller
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
