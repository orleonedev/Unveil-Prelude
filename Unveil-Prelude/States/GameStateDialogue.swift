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
        lakeDelightScene.audioInstance.backgroundMusicPlayer?.setVolume(0.3, fadeDuration: 0.5)
        lakeDelightScene.dialogueOverlay?.run(SKAction.fadeIn(withDuration: 0.3))
        lakeDelightScene.scriptInstance = lakeDelightScene.dialogueManager.getNextScript()
        lakeDelightScene.dialogueInstance = lakeDelightScene.scriptInstance?.getDialogue(numb: 0)
        lakeDelightScene.updateDialogue()
        }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        lakeDelightScene.audioInstance.backgroundMusicPlayer?.setVolume(0.8, fadeDuration: 0.5)
        lakeDelightScene.dialogueOverlay?.run(SKAction.fadeOut(withDuration: 0.3))
        DialogueManager.questPhase.next()
    }
    
    
}
