//
//  CollisionCategory.swift
//  CharacterStates
//
//  Created by Tarek Sanger on 2020-01-12.
//  Copyright © 2020 Tarek Sanger. All rights reserved.
//

public struct Collision {
    
    static let none: UInt32             = 0
    static let player: UInt32           = 0b1
    static let wall: UInt32             = 0b1 << 1

    enum Category {
        case none
        case player
        case wall

    }
    static let Detection: Dictionary<UInt32, Category> =
        [
            0:      Category.none,
            0b1:    Category.player,
            0b1<<1: Category.wall,
    ]
}
