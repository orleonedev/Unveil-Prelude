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
        return stateClass is GameStateMenu.Type || stateClass is GameStateDialogue.Type || stateClass is GameStateDialogueEvent.Type || stateClass is GameStatePuzzle.Type || stateClass is GameStateEndCut.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Stato Explorative")
        lakeDelightScene.menuButton?.alpha = 1.0
        lakeDelightScene.interactButton?.alpha = 1.0
        lakeDelightScene.controller?.alpha = 1.0
        
        if lakeDelightScene.popUpShow{
            if let popUp = lakeDelightScene.childNode(withName: "//soulPopUp") {
                popUp.run(SKAction.sequence([
                    SKAction.run {
                        self.lakeDelightScene.audioInstance.playSoundEffect("pop.mp3")
                        
                    },
                    SKAction.fadeIn(withDuration: 1.0),
                    SKAction.wait(forDuration: 2.0),
                    SKAction.fadeOut(withDuration: 1.0)
                ]))
            }
            lakeDelightScene.popUpShow = false
        }
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        lakeDelightScene.menuButton?.alpha = 0.0
        lakeDelightScene.controller?.alpha = 0.0
        lakeDelightScene.interactButton?.alpha = 0.0
    }
}
