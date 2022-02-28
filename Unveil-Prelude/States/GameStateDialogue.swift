//
//  GameStateDialogue.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 22/02/22.
//


import Foundation
import GameplayKit

class GameStateDialogue: GKState {
    
    unowned var lakeDelightScene: LakeDelightScene
    
    init(scene: LakeDelightScene){
        self.lakeDelightScene = scene
        super.init()
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameStateActive.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Dialogue State")
        lakeDelightScene.dialogueOverlay?.alpha = 1.0
        }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        lakeDelightScene.dialogueOverlay?.alpha = 0.0
    }
}
