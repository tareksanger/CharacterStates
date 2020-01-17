//
//  LineModel.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import SpriteKit


struct LineModel {
    var startPoint: CGPoint
    var endPoint: CGPoint
    var lineColor: UIColor
    
    func drawLine() -> SKShapeNode {
        //create the path
        let linePath = UIBezierPath()
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        //create the line as a SKShapeNode
        let lineLayer = SKShapeNode()
        lineLayer.path = linePath.cgPath
        lineLayer.lineWidth = 3
        lineLayer.strokeColor = lineColor
        return lineLayer
    }
    
    func animateComet() -> SKEmitterNode {
        // create emitter
        let emitter = SKEmitterNode()
        emitter.position = startPoint
        emitter.emissionAngle = calculateAngle()
        
        let cometImage = UIImage(named:"comet")!
        emitter.particleTexture = SKTexture(image: cometImage)
        
        let random = arc4random() % 2000 + 500
        emitter.particleBirthRate = 0.2 * CGFloat(random) / 1000
        emitter.particleLifetime = 10.0
        emitter.particleSpeed = 800
        emitter.particleSpeedRange = 700

       emitter.particleRotation = calculateAngle()
        
        return emitter
    }
    
    func calculateAngle() -> CGFloat {
        let deltaX = endPoint.x - startPoint.x
        let deltaY = endPoint.y - startPoint.y
        return atan2(deltaY, deltaX)
    }
}
