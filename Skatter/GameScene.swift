//
//  GameScene.swift
//  Skatter
//
//  Created by Nelson Gonzalez on 9/19/20.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "background")
    let player = SKSpriteNode(imageNamed: "skater")
    
    
    override func didMove(to view: SKView) {
       
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -6.0)
        
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        createSidewalk()
        createSkater()
    }
    
    func createSidewalk() {
       
        for i in 0 ... 10 {
            let sidewalk = SKSpriteNode(imageNamed: "sidewalk")
            sidewalk.zPosition = 1
            sidewalk.size = CGSize(width: 100, height: 100)
            sidewalk.anchorPoint = CGPoint.zero
            sidewalk.position = CGPoint(x: (sidewalk.size.width * CGFloat(i)) - CGFloat(1 * i), y: -20)
            sidewalk.physicsBody?.affectedByGravity = false
            sidewalk.physicsBody?.isDynamic = false
            addChild(sidewalk)
            
            let moveLeft = SKAction.moveBy(x: -sidewalk.size.width, y: 0, duration: 20)
            let moveReset = SKAction.moveBy(x: sidewalk.size.width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)

            //So, each sidewalk will move to the left a distance equal to its width, then jump back another distance equal to its width. This repeats in a sequence forever, so the mountains loop indefinitely
            sidewalk.run(moveForever)
            
            
        }
    }
    
    func createSkater() {
        
        player.position = CGPoint(x: frame.midX / 4.0, y: player.frame.height / 2.0)
        player.zPosition = 3
        player.position.y = player.frame.height / 2.0 + 74.0
                
        player.zRotation = 0.0
        player.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
        player.physicsBody?.angularVelocity = 0.0
        
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.texture!.size())
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.density = 6.0
        player.physicsBody?.allowsRotation = true
        player.physicsBody?.angularDamping = 1.0
                    
       // player.physicsBody?.categoryBitMask = PhysicsCategory.skater
       // player.physicsBody?.collisionBitMask = PhysicsCategory.brick
       // player.physicsBody?.contactTestBitMask = PhysicsCategory.brick | PhysicsCategory.gem
        addChild(player)
    }
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    
   
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
