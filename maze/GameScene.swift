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
    var score:Int = 0
    var scoreLabel = SKLabelNode()
    var second:Double? = 10.0
    var timerLabel = SKLabelNode()
    var levelTimer = Timer()
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        
        endNode = self.childNode(withName: "endNode") as! SKSpriteNode
        
        scoreLabel = self.childNode(withName: "scoreLabel") as! SKLabelNode
        timerLabel = self.childNode(withName: "timerLabel") as! SKLabelNode
        
        player.scale(to: CGSize(width: 100, height: 100))

        
        levelTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: "increaseTimer", userInfo: nil, repeats: true)
        
        
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        // grabs data from accelerometer every 0.1s, runs next line
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)! * 10), dy: CGFloat((data?.acceleration.y)! * 10))
        }
    }
    
    func increaseTimer(){
        if second! >= 1.0{
            second = second! - 1.0
            print(second)
            timerLabel.text = String(describing: second!)
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2 || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 1 {
            // endscene
            print("You Won!")
            if second! >= 1.0 {
                score += 1
            }
            
            print(score)
            scoreLabel.text = String(score)
            
           
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       player.scale(to: CGSize(width: 50, height: 50))
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.scale(to: CGSize(width: 100, height: 100))

    }


    
    override func update(_ currentTime: CFTimeInterval) {
        // Called before each frame is rendered
    }
}
