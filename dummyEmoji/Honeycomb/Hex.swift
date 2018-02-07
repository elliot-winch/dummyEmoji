//
//  Hex.swift
//  dummyEmoji
//
//  Created by Christopher Winch on 13/01/2018.
//  Copyright © 2018 Elliot Winch. All rights reserved.
//

import SpriteKit


public class HoneyCombLine : SKNode {
    
    //the startpoint is the position of the SKNode.
    //Having an SKNode also allows for children of the line
    let angle : CGFloat
    
    public init(point: CGPoint, angle: CGFloat) {
        self.angle = angle

        super.init()
        
        self.position = point
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.angle = 0

        super.init(coder: aDecoder)
        
        print("Line init'ed without angle assigned")
    }
    
    /*
     Returns a point in the scene x distance from the start point
    */
    public func getPointAlongLine(distance: CGFloat) -> CGPoint{
        return CGPoint(x: position.x + distance * cos(angle), y: position.y + distance * sin(angle))
    }
    
    public func getIntersection(line: HoneyCombLine) -> CGPoint{
        let dir = CGPoint(x: cos(self.angle), y: sin(self.angle))
        let dirLine = CGPoint(x: cos(line.angle), y: sin(line.angle))
        
        let xIntersect = ((self.position.x * dirLine.y) - (self.position.y * dirLine.x) + (line.position.y * dirLine.x) - (line.position.x * dirLine.y)) / ((dir.y * dirLine.x) - (dir.x * dirLine.y))
        
        let yIntersect = (self.position.x - line.position.x + (xIntersect * dir.x)) / dirLine.x
        
        return CGPoint(x: xIntersect, y: yIntersect)
        
        //(AxUy - AyUx + ByUx - BxUy) / (VyUx - VxUy)
        //S = (Ax - Bx + RVx) / Ux
    }
}

/*
public class HexNode : SKSpriteNode {
    
    //Initialisers
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        onDestroy = nil
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        onDestroy = nil
        
    }
    
    //Movement
    public var touchesBeganPosition : CGPoint?
    
    var onDestroy : ((HexNode) -> ())?
    
    public func RegisterOnDestroy( callback: @escaping (HexNode) -> () ){
        if(onDestroy == nil){
            onDestroy = { (hex) -> () in
                callback(hex)
            }
        } else {
            onDestroy = { (hex) -> () in
                self.onDestroy!(hex)
                callback(hex)
            }
        }
    }
    
    //Scale when moving
    override public var position: CGPoint {
        didSet {
            if(self.scene != nil){
                scaleHex()
            }
        }
    }
    
    func scaleHex(){
        
        //the size is inversely squared proportional to the distance from hex.position and (0,0)
        if let hexScene = self.scene as? HoneycombScene{

            let vectorLength = sqrt((self.position.x * self.position.x) + (self.position.y * self.position.y))

            if(vectorLength > hexScene.maxVectorLength){

                    if(onDestroy != nil){
                        onDestroy!(self)
                    }
                
                    let normalisedPositionVector = CGPoint(x: position.x / vectorLength, y: position.y / vectorLength)
                    let spawnDistanceFromCenter = CGFloat(hexScene.maxVectorLength * 2 - vectorLength)
                
                    hexScene.spawnHex(position: CGPoint(x: -normalisedPositionVector.x * spawnDistanceFromCenter, y: -normalisedPositionVector.y * spawnDistanceFromCenter))
                
                self.removeFromParent()

                return
            }
        
            //Linear
            //let scalingGradient = maxScale / maxVectorLength
            //let size = maxScale - (scalingGradient * vectorLength)
            
            let size = (-((vectorLength / hexScene.maxVectorLength) * (vectorLength / hexScene.maxVectorLength)) + 1) * maxScale
            
            self.scale(to: CGSize(width: size, height: size))
        }
    }

    //Data
    
}
 */
