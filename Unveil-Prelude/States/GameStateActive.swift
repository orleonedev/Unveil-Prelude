//
//  GameStateActive.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 22/02/22.
//

import Foundation
import GameplayKit

class GameStateActive: GKState {
    
    unowned var lakeDelightScene: LakeDelightScene
    
    init(scene: LakeDelightScene){
        self.lakeDelightScene = scene
        super.init()
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameStateMenu.Type || stateClass is GameStateDialogue.Type || stateClass is GameStateDialogueEvent.Type || stateClass is GameStatePuzzle.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Stato Explorative")
        lakeDelightScene.menuButton?.alpha = 1.0
        lakeDelightScene.interactButton?.alpha = 1.0
        lakeDelightScene.controller?.alpha = 1.0
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        lakeDelightScene.menuButton?.alpha = 0.0
        lakeDelightScene.controller?.alpha = 0.0
        lakeDelightScene.interactButton?.alpha = 0.0
    }
}
