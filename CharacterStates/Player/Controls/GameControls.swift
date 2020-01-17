//
//  GameControls.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import SpriteKit

extension PlayScene {
    @objc func moveHorizontal(_ sender: UIPanGestureRecognizer) {
        guard sender.view != nil else {return}
        
        let view = sender.view!
//        let velocity = sender.velocity(in: view)
//        print("Help")
        switch sender.state {
        case .began:
            // do Nothing
            print("Move Began")
            player.moving = true
            if player.touchingGround {
                player.enterState(RunningState.self)
            }
        case .changed:
            handleChange(sender, in: view)
        case .cancelled:
            print("Canceled")
            player.moving = false
            if player.touchingGround {
                player.enterState(IdleState.self)
            }
        case .ended:
            print("ended")
            player.moving = false
            if player.touchingGround {
                player.enterState(IdleState.self)
            }
        
        default:
            print("Nothing")
        }
    }
    
    
    private func handleChange(_ sender: UIPanGestureRecognizer, in view: UIView) {
        let translation = sender.translation(in: view)
        
        if (translation.x > 8 && player.currentDirection() != 1) || (translation.x < -8 && player.currentDirection() != -1){
            player.enterState(ChangeDirectionState.self)
        }
    }
    
    @objc func jumpControl(_ sender: UITapGestureRecognizer) {
        guard sender.view != nil else {return}
        switch sender.state {
        case .cancelled:
            print("Canceled")
        case .ended:
            print("ended")
//            player.jump(with: )
            player.enterState(JumpingState.self)
//            player.enterState(IdleState.self)
        default:
            print("Nothing")
        }
    }
    
    @objc func slideControl(_ sender: UISwipeGestureRecognizer) {
        guard sender.view != nil else {return}
        switch sender.state {
        case .cancelled:
            print("Canceled")
        case .ended:
            print("ended")
            player.enterState(SlidingState.self)

        default:
            print("Nothing")
        }
        
    }
    
}

class  GameControls {
    
    func create(_ scene: SKScene) {
        
        
        
        
        let leftView = SKView(frame: CGRect(x: scene.frame.minX, y: scene.frame.minY, width: scene.frame.width/2, height: scene.frame.height))
        let leftScene = SKScene(size: leftView.bounds.size)
        leftScene.backgroundColor = .clear
        leftView.presentScene(leftScene)
        leftView.allowsTransparency = true
        scene.view?.addSubview(leftView)
        
        let moveControl = UIPanGestureRecognizer()
        
        moveControl.addTarget(scene, action: #selector(PlayScene.moveHorizontal(_:)))
        moveControl.maximumNumberOfTouches = 1
        
        leftView.addGestureRecognizer(moveControl)
        
        
        let rightView = SKView(frame: CGRect(x: scene.frame.midX, y: scene.frame.minY, width: scene.frame.width/2, height: scene.frame.height))
        let rightScene = SKScene(size: rightView.bounds.size)
        rightScene.backgroundColor = .clear
        rightView.presentScene(leftScene)
        rightView.allowsTransparency = true
        scene.view?.addSubview(rightView)
        
        let jumpControl = UITapGestureRecognizer()
        
        jumpControl.addTarget(scene, action: #selector(PlayScene.jumpControl(_:)))
        jumpControl.numberOfTapsRequired = 1
        jumpControl.numberOfTouchesRequired = 1
        rightView.addGestureRecognizer(jumpControl)
        
        let slideControl = UISwipeGestureRecognizer()
        
        slideControl.addTarget(scene, action: #selector(PlayScene.slideControl(_:)))
        slideControl.direction = .down
        rightView.addGestureRecognizer(slideControl)
    }
}
