//
//  GameViewController.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var scene = GameScene()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scene = StartScene(size: self.view.bounds.size)
        if let view = self.view as! SKView? {
            
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            //            scene.sceneStateMachine = initSceneStateMachine(with: scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            
            // Present the scene
            view.presentScene(scene)
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
