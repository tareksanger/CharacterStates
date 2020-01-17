//
//  MovementState.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

import Foundation

import GameplayKit

class MovementState: GKState {
    
    let player: Player
    
    init(player: Player){
        self.player = player
    }
}
