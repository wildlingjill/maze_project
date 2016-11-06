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
    var heart_6 = SKSpriteNode()
    var heart_2 = SKSpriteNode()
    var heart_3 = SKSpriteNode()
    var heart_4 = SKSpriteNode()
    var heart_5 = SKSpriteNode()
    
    var score:Int = 0
    var scoreLabel = SKLabelNode()
    var second:Double? = 30.0
    var timerLabel = SKLabelNode()
    var levelTimer = Timer()
    
    override func didMove(to view: SKView) {

        self.physicsWorld.contactDelegate = self
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        
        heart_6 = self.childNode(withName: "heart_6") as! SKSpriteNode
        heart_2 = self.childNode(withName: "heart_2") as! SKSpriteNode
        heart_3 = self.childNode(withName: "heart_3") as! SKSpriteNode
        heart_4 = self.childNode(withName: "heart_4") as! SKSpriteNode
        heart_5 = self.childNode(withName: "heart_5") as! SKSpriteNode

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
        
        var speed = sqrt(player.physicsBody!.velocity.dx * 2 + player.physicsBody!.velocity.dy * 2)
    }
    
    func increaseTimer(){
        if second! >= 1.0{
            second = second! - 1.0
            print(second)
            timerLabel.text = String(describing: second!)
        } else {
            player.physicsBody!.affectedByGravity = false
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var bodyA = contact.bodyA
        var bodyB = contact.bodyB
        
        for i in 2...6{
            if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == UInt32(i) || bodyA.categoryBitMask == UInt32(i) && bodyB.categoryBitMask == 1 {
                // endscene
                self.childNode(withName: "heart_" + String(i))?.removeFromParent()
                print("You touched!")
                second = second! + 3.0
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.scale(to: CGSize(width: 50, height: 50))
        player.physicsBody!.linearDamping += 5.5
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.scale(to: CGSize(width: 100, height: 100))
        player.physicsBody!.linearDamping -= 5.5
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        // Called before each frame is rendered
    }
}
