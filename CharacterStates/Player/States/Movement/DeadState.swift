//
//  DeadState.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import GameplayKit

class DeadState: MovementState {
    
    // MARK: Initializer
    
    override init(player: Player) {
        super.init(player: player)
    }
    
    // MARK: GKState Overrides
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdleState.Type, is RunningState.Type, is WalkingState.Type:
            return true
        default:
            print("Invalid State Change")
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState != nil {
            player.dead()
        }
        print("Idle")
    }
    
    override func willExit(to nextState: GKState) {
        
    }
}
