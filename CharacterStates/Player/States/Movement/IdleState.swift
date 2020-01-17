//
//  IdleState.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import GameplayKit

class IdleState: MovementState {
    
    // MARK: Initializer
    
    override init(player: Player) {
        super.init(player: player)
    }
    
    // MARK: GKState Overrides
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RunningState.Type, is ChangeDirectionState.Type, is WalkingState.Type, is JumpingState.Type, is DeadState.Type:
            return true
        default:
//            print("Invalid State Change")
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState != nil {
            player.idle()
        }
    }
    
    override func willExit(to nextState: GKState) {
        player.removeAllActions()
    }

}
