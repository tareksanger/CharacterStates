//
//  ChangeDirectionState.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import GameplayKit

class ChangeDirectionState: MovementState {
    
    // MARK: Initializer
    
    override init(player: Player) {
        super.init(player: player)
    }
    
    // MARK: GKState Overrides
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RunningState.Type, is WalkingState.Type, is JumpingState.Type:
            return true
        default:
            print("Invalid State Change")
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState != nil {
            self.update(deltaTime: 0.1)
            // Do Change Direction Animation...
            // ....
//            player.walkAnim()
            if player.currentDirection() != 1 {
                player.direction(1)
            } else {
                player.direction(-1)
            }
            
            // Then
            switch previousState {
            case is RunningState:
                player.enterState(RunningState.self)
            case is JumpingState:
                player.enterState(JumpingState.self)
            default:
                break
            }
        }
        print("ChangeDirection")
    }
    
    override func willExit(to nextState: GKState) {
//        player.stopAction(withKey: "PlayerIdle")
        if player.touchingGround {
            player.removeAllActions()
        }
    }
    
    override func update(deltaTime sec: TimeInterval) {
        if player.moving {
            player.run(sec)
        }
    }

}
