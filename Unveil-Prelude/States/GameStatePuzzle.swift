//
//  GameStatePuzzle.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 03/03/22.
//

import Foundation
import GameplayKit

class GameStatePuzzle : GKState {
    
    unowned var lakeDelightScene: LakeDelightScene
    
    init(scene: LakeDelightScene){
        self.lakeDelightScene = scene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameStateActive.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Puzzle")
        
        lakeDelightScene.puzzleOverlay?.alpha = 1.0
        
        }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        lakeDelightScene.puzzleOverlay?.alpha = 0.0
        lakeDelightScene.eventMapNode3?.removeFromParent()
        if let button = lakeDelightScene.interactButton?.childNode(withName: "//interact_button") as? SKSpriteNode {
            button.alpha = 0.3
            button.texture = SKTexture.init(imageNamed: "pulsanteazione")
        }
    }
    
}
