//
//  GameScene.swift
//  Skatter
//
//  Created by Nelson Gonzalez on 9/19/20.
//

import SpriteKit
import GameplayKit

struct Collision {
    static let skater: UInt32 = 0x1 << 0
    static let brick: UInt32 = 0x1 << 1
    static let gem: UInt32 = 0x1 << 2
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let background = SKSpriteNode(imageNamed: "background")
    let player = SKSpriteNode(imageNamed: "skater")
    
    let nc = NotificationCenter.default
    
    override func didMove(to view: SKView) {
       
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -6.0)
        
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        createSidewalk()
        createSkater()
        
        
        physicsWorld.contactDelegate = self
        
        startGems()
        
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
                    
        player.physicsBody?.categoryBitMask = Collision.skater
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = Collision.gem
        addChild(player)
    }
    
  func spawnGem() {
    
            // Greate a gem sprite and add it to the scene
       let gem = SKSpriteNode(imageNamed: "gem")
        
    gem.position = CGPoint(x: frame.maxX + 10, y: gem.frame.height / 2.0)
        gem.zPosition = 3
        gem.position.y = gem.frame.height / 2.0 + 74.0
        addChild(gem)
            
        gem.physicsBody = SKPhysicsBody(rectangleOf: gem.size, center: gem.centerRect.origin)
        gem.physicsBody?.categoryBitMask = Collision.gem
        gem.physicsBody?.collisionBitMask = 0
        gem.physicsBody?.contactTestBitMask = Collision.skater
        
        gem.physicsBody?.affectedByGravity = false
        gem.physicsBody?.velocity = CGVector(dx: -400, dy: 0) //move along the x only
        gem.physicsBody?.linearDamping = 0 //no friction
            
    
            // Add the new gem to the array of gems
        }
    
    @objc func startGems() {
    
        
        let create = SKAction.run { [unowned self] in
            
            
            self.spawnGem() //That new method calls createRocks(), waits three seconds, calls createRocks() again, waits again, and so on, forever.
           
        }
       
        
        let wait = SKAction.wait(forDuration: 2,withRange: 5)
        let sequence = SKAction.sequence([create, wait])
        let repeatForever = SKAction.repeatForever(sequence)
        
        run(repeatForever)
        
        
        
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

extension GameScene {
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("didBeginContact entered for \(String(describing: contact.bodyA.node!.name)) and \(String(describing: contact.bodyB.node!.name))")
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        switch contactMask {
        case Collision.skater | Collision.gem:
            print("Player and gem have collided")
            let gemNode = contact.bodyA.categoryBitMask == Collision.gem ? contact.bodyA.node : contact.bodyB.node

            gemNode!.removeFromParent()
           
        default:
            print("Some other contact occured")
        }

    }
}
