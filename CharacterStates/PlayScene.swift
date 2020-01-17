//
//  PlayScene.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import GameplayKit

class PlayScene: GameScene, SKPhysicsContactDelegate {
    
    var player = Player()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        
        backgroundColor = .blue
        
        // MARK: World Physics
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//        self.physicsWorld.gravity = leftSideGravity
        self.physicsBody!.categoryBitMask = Collision.wall
        self.physicsBody!.collisionBitMask = Collision.none
        self.physicsBody!.contactTestBitMask = Collision.player
        
        
        //MARK: Game Objects
        player.position = CGPoint(x: frame.midX, y: frame.minY + player.size.height)
        addChild(player)
        
        // Used for testing the player Jumpheight.
        let line = LineModel(startPoint: CGPoint(x: 0, y: 150), endPoint: CGPoint(x: frame.maxX, y: 150), lineColor: .red)
        addChild(line.drawLine())
        
        // MARK: Gesture Recognizers
        GameControls().create(self)
        

    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let categoryA: UInt32 = contact.bodyA.categoryBitMask
        let categoryB: UInt32 = contact.bodyB.categoryBitMask
        if categoryA == Collision.player || categoryB == Collision.player {
            if Collision.player == categoryA {
                if let otherNode = contact.bodyB.node {
                    player.didCollide(with: otherNode)
                }
            } else if Collision.player == categoryB {
                if let otherNode = contact.bodyA.node {
                    player.didCollide(with: otherNode)
                }
                
            }
        }
    }
    
    // MARK: Gesture Methods
    
}
