//
//  Honeycomb.swift
//  dummyEmoji
//
//  Created by Christopher Winch on 13/01/2018.
//  Copyright © 2018 Elliot Winch. All rights reserved.
//

import Foundation
import SpriteKit

let maxScale : CGFloat = 150
let numberOfHexsOnRadius = 3

public class HoneycombView : SKView {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        showsFPS = true
        showsNodeCount = true
    }
}

public class HoneycombScene : SKScene {
    
    var hexes = [HexNode]()
    var maxVectorLength : CGFloat
    var distanceBetweenHexes : CGFloat
    
    required public init?(coder aDecoder: NSCoder) {
        self.maxVectorLength = 0
        self.distanceBetweenHexes = 0
        
        super.init(coder: aDecoder)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.maxVectorLength = self.size.height / 2
        self.distanceBetweenHexes = maxVectorLength / CGFloat(numberOfHexsOnRadius)
        
        recPlaceInitialHexes(position: CGPoint.zero)
    }

    public func recPlaceInitialHexes(position: CGPoint){

        self.spawnHex(position: position)
        
        for i in 0..<6{
            
            let angle_rad = (CGFloat.pi / 180) * 60 * (CGFloat(i) + 0.5)
            
            let potentialPosition = CGPoint(x: Int( (distanceBetweenHexes * cos(angle_rad)) + position.x), y: Int((distanceBetweenHexes * sin(angle_rad)) + position.y))
            
            if (self.scene?.atPoint(potentialPosition) as? HexNode) != nil{
                continue
            }
            
            if( sqrt((potentialPosition.x * potentialPosition.x) + (potentialPosition.y * potentialPosition.y)) < maxVectorLength){
                recPlaceInitialHexes(position: potentialPosition)
            }
        }
    }
    
    public func spawnHex(position: CGPoint){
        let hexNode = HexNode(texture: SKTexture(imageNamed: "Hex"), color: UIColor.white, size: CGSize(width: 1, height: 1))

        hexes.append(hexNode)
        hexNode.move(toParent: self)

        hexNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        hexNode.position = position
        
        hexNode.onDestroy = { (hex) -> () in
            
            for i in 0..<self.hexes.count {
                if(self.hexes[i] === hex){
                    self.hexes.remove(at: i)
                    break
                }
            }
        }
    }
    
    var prevTouchPosition : CGPoint?
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(touches.count > 0){
            prevTouchPosition = touches.first?.location(in: self)
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.count > 0{
            
            let touchPosition = (touches.first?.location(in: self))!
            
            for hex in hexes {
                hex.position = CGPoint(x: hex.position.x + touchPosition.x - prevTouchPosition!.x, y: hex.position.y + touchPosition.y - prevTouchPosition!.y)
            }
            
            prevTouchPosition = touchPosition
        }
    }

}
