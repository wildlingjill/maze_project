//
//  GameScene.swift
//  aMazN
//
//  Created by JAGDIP SINGH on 11/4/16.
//  Copyright © 2016 Sandhu. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let manager = CMMotionManager()
    var player = SKSpriteNode()
    var endNode = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        
        endNode = self.childNode(withName: "endNode") as! SKSpriteNode
    
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 25, dy: CGFloat((data?.acceleration.y)!) * 25)
            
        }
        
}
    
    func didBeginContact(contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2 || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 1 {
            print("you won")
        }
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        // Called before each frame is rendered
    }
}
