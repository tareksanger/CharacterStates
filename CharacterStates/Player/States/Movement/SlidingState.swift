//
//  SlidingState.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import GameplayKit

class SlidingState: MovementState {
    
    // MARK: Initializer
    
    override init(player: Player) {
        super.init(player: player)
    }
    
    // MARK: GKState Overrides
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdleState.Type,
             is RunningState.Type,
             is WalkingState.Type,
             is JumpingState.Type,
             is DeadState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        if previousState != nil {
            player.slideAnim()
            player.slide()
        }
        print("Slide")
    }
    
    override func willExit(to nextState: GKState) {
        player.removeAllActions()

    }
    override func update(deltaTime seconds: TimeInterval) {

    }
}
