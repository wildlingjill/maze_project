//
//  GameScene.swift
//  maze
//
//  Created by Jill Robinson on 04/11/2016.
//  Copyright © 2016 Jill Robinson. All rights reserved.
//

import SpriteKit
// import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    let manager = CMMotionManager()
    var player = SKSpriteNode()
    var endNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        
        endNode = self.childNode(withName: "endNode") as! SKSpriteNode
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        // grabs data from accelerometer every 0.1s, runs next line
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)! * 10), dy: CGFloat((data?.acceleration.y)! * 10))
        }
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2 || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 1 {
            // endscene
            print("You Won!")
            // create the alert
            let alert = UIAlertController(title: "Game over", message: "You won!", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        // Called before each frame is rendered
    }
}
