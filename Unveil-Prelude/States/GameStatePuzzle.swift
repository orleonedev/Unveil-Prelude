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
        lakeDelightScene.menuOverlay?.alpha = 1.0
        lakeDelightScene.questTitle?.text = "Puzzle"
        lakeDelightScene.questDescription?.text = "Puzzle Puzzle Puzzle Puzzle"
        
        }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        lakeDelightScene.menuOverlay?.alpha = 0.0
        lakeDelightScene.eventMapNode3?.removeFromParent()
        if let button = lakeDelightScene.interactButton?.childNode(withName: "//interact_button") as? SKSpriteNode {
            button.alpha = 0.3
            button.texture = SKTexture.init(imageNamed: "pulsanteazione")
        }
    }
    
}
