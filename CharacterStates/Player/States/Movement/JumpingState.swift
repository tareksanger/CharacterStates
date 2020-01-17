//
//  JumpingState.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import GameplayKit

class JumpingState: MovementState {
    
    // MARK: Initializer
    private var prevState: GKState?
    
    override init(player: Player) {
        super.init(player: player)
    }
    
    // MARK: GKState Overrides
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdleState.Type, is RunningState.Type, is ChangeDirectionState.Type,  is WalkingState.Type, is DeadState.Type, is JumpingState.Type:
            return true
        default:
            print("Invalid State Change")
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState != nil {
            self.update(deltaTime: 0.1)
            self.prevState = previousState
                if player.touchingGround {
                    player.jump()
            }
        }
        print("Jump")
    }
    
    override func willExit(to nextState: GKState) {
        player.removeAction(forKey: "PlayerMove")

    }
    
    override func update(deltaTime sec: TimeInterval) {
        if player.moving {
            player.run(sec)
        }
    }
}
