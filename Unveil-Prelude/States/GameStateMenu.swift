//
//  GameStateMenu.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 22/02/22.
//

import Foundation
import GameplayKit

class GameStateMenu: GKState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameStateActive.Type
    }
    
    override func didEnter(from previousState: GKState?) {
            print("Menu State")
        }
}
