//
//  GameStateDialogueEvent.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 03/03/22.
//


import Foundation
import GameplayKit

class GameStateDialogueEvent: GKState {
    
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
        switch DialogueManager.questPhase{
        case .start:
        lakeDelightScene.dialogueInstance = uponBottomMarginDialogue
        case .first:
            lakeDelightScene.dialogueInstance = uponBottomMarginDialogue
        case .second:
            lakeDelightScene.dialogueInstance = uponBottomMarginDialogue2
    //  case .third:
            //lakeDelightScene.dialogueInstance = uponBottomMarginDialogue3
        }
        lakeDelightScene.updateDialogue()
        }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        lakeDelightScene.dialogueOverlay?.alpha = 0.0
        
    }
    
    
}
