//
//  SKLabel.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import SpriteKit

extension SKLabelNode {
    convenience init?(fontNamed font: String, andText text: String, andSize size: CGFloat, withShadow shadow: UIColor) {
        self.init(fontNamed: font)
        self.text = text
        self.fontSize = size
        
        let shadowNode = SKLabelNode(fontNamed: font)
        shadowNode.text = self.text
        shadowNode.zPosition = self.zPosition - 1
        shadowNode.fontColor = shadow
        // Just create a little offset from the main text label
        shadowNode.position = CGPoint(x: 5, y: -5)
        shadowNode.fontSize = self.fontSize
        shadowNode.alpha = 0.5
        
        self.addChild(shadowNode)
    }
}
