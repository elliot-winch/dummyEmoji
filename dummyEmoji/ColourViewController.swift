//
//  ViewController.swift
//  dummyEmoji
//
//  Created by Christopher Winch on 29/12/2017.
//  Copyright © 2017 Elliot Winch. All rights reserved.
//

import UIKit
import Firebase

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
            
            if newVal <= 255 && newVal >= 0 {
                newVal = newVal/CGFloat(255)
            } else if newVal < 0 {
                newVal = 0
                newValInt = 0
            } else {
                newVal = 1
                newValInt = 255
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
                sender.text = String(describing: Int(blueVal * 255))
            } else if (sender.tag == 102){
                sender.text = String(describing: Int(redVal * 255))

            } else if (sender.tag == 103){
                sender.text = String(describing: Int(greenVal * 255))

            } else {
                print("Incorrect tagging")
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
