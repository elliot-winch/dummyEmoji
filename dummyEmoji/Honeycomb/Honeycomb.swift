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
  /*
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
 */
    
    var verticalLines : [HoneyCombLine] = [HoneyCombLine]()
    var leftLines : [HoneyCombLine] = [HoneyCombLine]()
    var rightLines : [HoneyCombLine] = [HoneyCombLine]()

    let distBetween : CGFloat = 100.0 //temp
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let screenWidth = self.scene!.size.width
        let numVerticalLines = Int(screenWidth / distBetween) //will be average distance between lines
        
        for i in 0..<numVerticalLines {
        
            verticalLines.append(spawnLine(position: CGPoint(x: CGFloat(i) * distBetween - (screenWidth / 2), y: 0.0), angle: CGFloat.pi / 2.0))
        }
   
        let leftAngle = CGFloat.pi / 6.0
        let rightAngle = CGFloat.pi * 5.0 / 6.0
        let heightToFill = self.scene!.size.height + screenWidth * tan(leftAngle)
        let numHorizontalLines = Int(heightToFill / distBetween)
        
        for i in 0..<numHorizontalLines {
            //Left
            leftLines.append(spawnLine(position: CGPoint(x: 0.0, y: CGFloat(i) * distBetween - (heightToFill / 2)), angle: leftAngle))
            
            //Right
            rightLines.append(spawnLine(position: CGPoint(x: 0.0, y: CGFloat(i) * distBetween - (heightToFill / 2)), angle: rightAngle))
        }
        
        for v in verticalLines {
            for l in leftLines {
                spawnHex(position: v.getIntersection(line: l), parent: v)
            }
            
            for r in rightLines {
                spawnHex(position: v.getIntersection(line: r), parent: v)
            }
        }
        
        for l in leftLines {
            for r in rightLines {
                spawnHex(position: l.getIntersection(line: r), parent: l)

            }
        }

    }
    
    func spawnHex(position: CGPoint, parent: SKNode) {
        let hex = SKSpriteNode(texture: nil, color: UIColor.red, size: CGSize(width: 20.0, height: 20.0))
        
        hex.position = position
        
        hex.move(toParent: parent)
    }
    
    func spawnLine(position: CGPoint, angle: CGFloat) -> HoneyCombLine{
        let line = HoneyCombLine(point: position, angle: angle)
        
        line.move(toParent: self)
        
        return line
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
            
            let moveVector = CGPoint(x: touchPosition.x - prevTouchPosition!.x, y: touchPosition.y - prevTouchPosition!.y)
            
            
            for line in verticalLines {

                line.position = CGPoint(x: line.position.x + moveVector.x, y: line.position.y)
                
                for child in line.children {
                    child.position = CGPoint(x: child.position.x, y: child.position.y + moveVector.y)
                }
            }
            
            for line in leftLines {
                line.position = CGPoint(x: line.position.x, y: line.position.y + moveVector.y)
                
                for child in line.children {
                    child.position = CGPoint(x: child.position.x + moveVector.x, y: child.position.y)
                    
                }
            }
            
            for line in rightLines {
                line.position = CGPoint(x: line.position.x, y: line.position.y + moveVector.y)
                
                for child in line.children {
                    child.position = CGPoint(x: child.position.x + moveVector.x, y: child.position.y)
                    
                }
            }
            
            prevTouchPosition = touchPosition
        }
    }
}



 
