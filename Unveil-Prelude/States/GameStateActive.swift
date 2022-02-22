//
//  GameStateActive.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 22/02/22.
//

import Foundation
import GameplayKit

class GameStateActive: GKState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameStateMenu.Type || stateClass is GameStateDialogue.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Stato Explorative")
    }
}
