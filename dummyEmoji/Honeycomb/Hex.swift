//
//  Hex.swift
//  dummyEmoji
//
//  Created by Christopher Winch on 13/01/2018.
//  Copyright © 2018 Elliot Winch. All rights reserved.
//

import SpriteKit

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
