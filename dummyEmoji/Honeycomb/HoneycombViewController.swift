//
//  HoneycombViewController.swift
//  dummyEmoji
//
//  Created by Christopher Winch on 13/01/2018.
//  Copyright © 2018 Elliot Winch. All rights reserved.
//

import UIKit
import SpriteKit

class HoneycombViewController: UIViewController {
    
    @IBOutlet weak var honeycombView: HoneycombView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = honeycombView
        
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "Honeycomb"){
                
                scene.scaleMode = .aspectFill
                
                view.presentScene(scene)
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
