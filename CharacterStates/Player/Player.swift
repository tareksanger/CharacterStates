//
//  Player.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import SpriteKit
import GameplayKit

class Player: SKSpriteNode {
    
    private var runFrames: [SKTexture] = []
    private var walkFrames: [SKTexture] = []
    private var jumpFrames: [SKTexture] = []
    private var slideFrames: [SKTexture] = []
    private var idleFrames: [SKTexture] = []
    private var deadFrames: [SKTexture] = []
    
    private var movementState: GKStateMachine!
    private var speed_: CGFloat!
    private var direction: Int = 1
    
//    private var impulse: CGFloat!
    
    let ptu = 1.0 / sqrt(SKPhysicsBody(rectangleOf: CGSize(width:1,height:1)).mass)
    
    var moving = false
    var touchingGround = true
    
    private var jumpImpulse: CGFloat!
    private var jumpHangTime: CGFloat = 0.9/1.5
    private var slideImpulse: CGFloat!
    private let slideDistance: CGFloat = 100
    
    
    init(jumpHeight: CGFloat = 150, worldGravity: CGFloat = -9.8) {
        let playerTexture: SKTexture = SKTexture(imageNamed: "Idle (1)")
        super.init(texture: playerTexture, color: .white, size: CGSize(width: 50, height: 50))
        self.physicsBody = SKPhysicsBody(texture: playerTexture, size: CGSize(width: self.size.width, height: self.size.height))
        self.physicsBody!.affectedByGravity     = true
        self.physicsBody!.allowsRotation        = false
        self.physicsBody!.categoryBitMask       = Collision.player
        self.physicsBody!.collisionBitMask      = Collision.wall
        self.physicsBody!.contactTestBitMask    = Collision.wall
        
        speed_ = 14
        jumpImpulse = calculateImpuseDY_DX(mass: self.physicsBody!.mass, gravityDY: worldGravity, distance: jumpHeight, ptu: ptu)
        slideImpulse = calculateImpuseDY_DX(mass: self.physicsBody!.mass, gravityDY: worldGravity, distance: slideDistance, ptu: ptu)

        moving = false
        touchingGround = true
        
        walkFrames = createFrames(with: "Walk")
        runFrames = createFrames(with: "Run")
        jumpFrames = createFrames(with: "Jump")
        slideFrames = createFrames(with: "Slide")
        idleFrames = createFrames(with: "Idle")
        deadFrames = createFrames(with: "Dead")
        
        movementState = GKStateMachine(states: [
        IdleState(player: self),
        RunningState(player: self),
        WalkingState(player: self),
        ChangeDirectionState(player: self),
        JumpingState(player: self),
        SlidingState(player: self),
        DeadState(player: self)
        ])
        
        movementState.enter(IdleState.self)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func createFrames(with textureAtlas: String) -> [SKTexture] {
        let animatedAtlas = SKTextureAtlas(named: "p\(textureAtlas)")
        var frames: [SKTexture] = []
        
        let numImages = animatedAtlas.textureNames.count
        for i in 1...numImages {
          let textureName = "\(textureAtlas) (\(i))"
          frames.append(animatedAtlas.textureNamed(textureName))
        }
        
        return frames
    }
    
    
    func enterState(_ state: AnyClass){
        self.movementState.enter(state)
    }
    
    func MovementState() -> GKStateMachine {
        return movementState
    }
    
    func speed() -> CGFloat {
        return speed_
    }
    
    func currentDirection() -> Int{
        return direction
    }
    func direction(_ d : Int){
        self.direction = d
        self.xScale = abs(self.xScale) * CGFloat(d)
    }
    
    func stopAction(withKey key: String) {
        self.removeAction(forKey: key)
    }
    
    
    func idle(){
        if self.action(forKey: "PlayerIdle") == nil {
        self.run(SKAction.repeatForever(SKAction.animate(with: idleFrames,
                                                         timePerFrame: 0.1)),
                 withKey: "PlayerIdle" )
        }
    }
    
    func walkAnim() {
        if self.action(forKey: "PlayerWalk") == nil {
            self.run(SKAction.repeatForever(SKAction.animate(with: walkFrames,
                                                timePerFrame: 0.1)),
                     withKey: "PlayerWalk" )
        }
    }
    
    func walk(_ seconds: TimeInterval){
        self.run(SKAction.repeatForever(SKAction.moveBy(x: 9 * CGFloat(direction), y: 0, duration: seconds)))
    }
    
    func runAnim() {
        if self.action(forKey: "PlayerRun") == nil {
            self.run(SKAction.repeatForever(SKAction.animate(with: runFrames,
                                                    timePerFrame: 0.1)),

            withKey: "PlayerRun" )
        }
    }
    
    func run(_ seconds: TimeInterval){
        self.run(SKAction.repeatForever(SKAction.move(by: CGVector(dx: self.speed_ * CGFloat(direction), dy: 0), duration: seconds)), withKey:"PlayerMove")
    }
    
    func jumpAnim() {
        if self.action(forKey: "PlayerJump") == nil {
            print("\(jumpHangTime)")
            self.run(SKAction.animate(with: jumpFrames, timePerFrame: TimeInterval(jumpHangTime/10)), withKey: "PlayerJump")
        }
       
    }
    
    /*
     Jump
     
     
     touchingGround is set to false here
     
     */
    func jump(){
        touchingGround = false
        self.jumpAnim()
        self.physicsBody!.applyImpulse(CGVector(dx: 0, dy: jumpImpulse!))
        
    }
    func slideAnim() {
        self.run(SKAction.animate(with: slideFrames, timePerFrame: 0.05, resize: false, restore: true), withKey: "PlayerSlide")
    }
    
    func slide() {

        self.run(SKAction.move(by: CGVector(dx: slideDistance * CGFloat(direction), dy: 0), duration: 0.5), completion: {
            if self.moving {
                self.enterState(RunningState.self)
            } else {
                self.enterState(IdleState.self)
            }
        })
    }
    
    
    func dead() {
        
    }
    
    
    func inContactWith() -> [SKPhysicsBody]{
        return self.physicsBody!.allContactedBodies()
    }
    
    func didCollide(with other: SKNode) {
        if let otherCategory = Collision.Detection[other.physicsBody!.categoryBitMask] {
            switch otherCategory {
            case .wall:
                if !self.touchingGround {
                    self.removeAction(forKey: "PlayerJump")
                    if self.movementState.currentState is JumpingState && self.moving{
                        self.enterState(RunningState.self)
                    } else {
                        self.enterState(IdleState.self)
                    }
                    self.touchingGround = true
                }
            default:
                break
            }
        }
    }
    
    
    
    private func calculateImpuseDY_DX(mass: CGFloat, gravityDY: CGFloat, distance: CGFloat, ptu: CGFloat) -> CGFloat {
    return mass * sqrt(2 * -gravityDY * distance * ptu)
    }
    
}
