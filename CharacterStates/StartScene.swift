//
//  StartScene.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import GameplayKit

class StartScene: GameScene{
    
    // MARK: Properties
    
    var titleLabel = SKLabelNode(fontNamed: "GillSans-UltraBold", andText: "GAME", andSize: 50, withShadow: UIColor.black)!
    var startLabel = SKLabelNode()
    
    let lineColor = UIColor.white.withAlphaComponent(0.3)
    var lines: [LineModel] = []
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        backgroundColor = .red
        //MARK: Background
        
        // Comet Lines
        lines = [
            LineModel(startPoint: CGPoint(x: frame.midX, y: -10), endPoint: CGPoint(x: frame.maxX + 10, y: frame.midY/2), lineColor: lineColor),
            LineModel(startPoint: CGPoint(x: -10, y: frame.midY * 0.3), endPoint: CGPoint(x: frame.midX * 0.45, y: -10), lineColor: lineColor),
            LineModel(startPoint: CGPoint(x: frame.midX * 1.65, y: -10), endPoint: CGPoint(x: frame.maxX+10, y: frame.midY * 1.75), lineColor: lineColor),
            LineModel(startPoint: CGPoint(x: frame.maxX + 10, y: frame.midY * 1.34), endPoint: CGPoint(x: -10, y: frame.maxY * 0.86), lineColor: lineColor),
            LineModel(startPoint: CGPoint(x: -10, y: frame.midY * 1.23), endPoint: CGPoint(x: frame.midX * 0.372, y: frame.maxY + 10), lineColor: lineColor),
            LineModel(startPoint: CGPoint(x: frame.midX * 1.23, y: frame.maxY + 10), endPoint: CGPoint(x: frame.maxX + 10, y: frame.midY * 1.64), lineColor: lineColor),
            LineModel(startPoint: CGPoint(x: frame.maxX + 10, y: frame.midY * 0.68), endPoint: CGPoint(x:  -10, y: frame.midY * 0.894), lineColor: lineColor)
            ]

        for line in lines {
            addChild(line.drawLine())
            addChild(line.animateComet())
        }
        
        // Labels
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(titleLabel)
        
        startLabel.position = CGPoint(x: titleLabel.position.x, y: titleLabel.position.y - (titleLabel.frame.height * 1.25))
        startLabel.text = "Tap to Start"
        startLabel.fontName = "GillSans-SemiBold"
        startLabel.fontSize = titleLabel.fontSize/2
        startLabel.alpha = 0.5
        addChild(startLabel)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        toPlayScene()
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
}
