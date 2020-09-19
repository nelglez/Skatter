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
    
    
    override func didMove(to view: SKView) {
       
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
        
        createSidewalk()
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
