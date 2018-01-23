//
//  ViewController.swift
//  dummyEmoji
//
//  Created by Christopher Winch on 29/12/2017.
//  Copyright © 2017 Elliot Winch. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ColourViewController: UIViewController {
    
    private var redVal : CGFloat = 0
    private var blueVal : CGFloat = 0
    private var greenVal : CGFloat = 0
    

    @IBOutlet weak var favouriteColourDisplay: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    @IBAction func textFieldChanged(_ sender: UITextField) {
        
        let numberFormatter = NumberFormatter()
        
        if var newValInt = numberFormatter.number(from: sender.text!)?.intValue {
            
            var newVal = CGFloat(newValInt)
            
            if newVal <= 256 && newVal >= 0 {
                newVal = newVal/CGFloat(256)
            } else if newVal < 0 {
                newVal = 0
                newValInt = 0
            } else {
                newVal = 1
                newValInt = 256
            }
                
            if(sender.tag == 101){
                blueVal = newVal
                
            } else if (sender.tag == 102){
                redVal = newVal

            } else if (sender.tag == 103){
                greenVal = newVal

            } else {
                print("Incorrect tagging")
            }
            
            sender.text = String(newValInt)
            
            favouriteColourDisplay.backgroundColor = UIColor(red: redVal, green: greenVal, blue: blueVal, alpha: 1)
            
        } else {
            if(sender.tag == 101){
                sender.text = String(describing: Int(blueVal * 256))
            } else if (sender.tag == 102){
                sender.text = String(describing: Int(redVal * 256))

            } else if (sender.tag == 103){
                sender.text = String(describing: Int(greenVal * 256))

            } else {
                print("Incorrect tagging")
            }
        }
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            
            let userUID = Auth.auth().currentUser!.uid
            let userFavColorData = Database.database().reference().child("users/\(userUID)/favColor")
        
            userFavColorData.updateChildValues(["r": Int(redVal * 256), "g": Int(greenVal * 256), "b": Int(blueVal * 256)])
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
