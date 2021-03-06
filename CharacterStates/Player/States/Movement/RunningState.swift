//
//  RunningState.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import GameplayKit

class RunningState: MovementState {
    
    // MARK: Initializer
    
    override init(player: Player) {
        super.init(player: player)
    }
    
    // MARK: GKState Overrides
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdleState.Type, is RunningState.Type, is WalkingState.Type, is ChangeDirectionState.Type, is JumpingState.Type, is SlidingState.Type, is DeadState.Type:
                return true
            default:
                print("Invalid State Change")
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState != nil {
            player.runAnim()
            self.update(deltaTime: 0.1)
            
        }
    }
    
    override func willExit(to nextState: GKState) {
        player.removeAllActions()
    }
    
    override func update(deltaTime sec: TimeInterval) {
        player.run(sec)
    }

}
