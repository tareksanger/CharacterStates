//
//  GameScene.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import SpriteKit
import GameplayKit

import GameplayKit

class GameScene: SKScene, UIGestureRecognizerDelegate {
    
    // MARK: Properties
    
    
    override func didMove(to view: SKView) {
    }
    
    // MARK: Change Scene Methods
    func toStartScene() {
        print("\nEntering Start Scene")
        let scene = StartScene(size: self.view!.bounds.size)
        newScene(with: scene, transition: SKTransition.push(with: SKTransitionDirection.down, duration: 2))
    }
    
    func toPlayScene() {
        print("\nEntering Play Scene")
        let scene = PlayScene(size: self.view!.bounds.size)
        newScene(with: scene, transition: SKTransition.moveIn(with: SKTransitionDirection.left, duration: 2))
    }
    
    
    func newScene(with scene: GameScene, transition: SKTransition) {
        if let skView = self.view {
            
            // Sprite Kit applies additional optimizations to improve rendering performance
            skView.ignoresSiblingOrder = true
            
            // Set the scale mode to scale to fit the window
            //    newScene.scaleMode = .aspectFill
            
            // Present Scene
            skView.presentScene(scene, transition: transition)
        }
    }
    
    
}
