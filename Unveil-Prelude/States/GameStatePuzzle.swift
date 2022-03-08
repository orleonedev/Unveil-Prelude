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
        return stateClass is GameStateDialogue.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        lakeDelightScene.audioInstance.backgroundMusicPlayer?.setVolume(0.0, fadeDuration: 0.5)
        lakeDelightScene.audioInstance.backgroundMusicPlayer2?.setVolume(0.6, fadeDuration: 0.5)
        
        lakeDelightScene.startPosition = nil
        lakeDelightScene.currentNode = nil
        print("Puzzle")
        
        lakeDelightScene.puzzleOverlay?.alpha = 1.0
        
        lakeDelightScene.gemmaRossa1 = lakeDelightScene.puzzleOverlay?.childNode(withName: "//GemmaRossa1") as? SKSpriteNode
        lakeDelightScene.gemmaRossa2 = lakeDelightScene.puzzleOverlay?.childNode(withName: "//GemmaRossa2") as? SKSpriteNode
        lakeDelightScene.gemmaRossa3 = lakeDelightScene.puzzleOverlay?.childNode(withName: "//GemmaRossa3") as? SKSpriteNode
        lakeDelightScene.gemmaVerde1 = lakeDelightScene.puzzleOverlay?.childNode(withName: "//GemmaVerde1") as? SKSpriteNode
        lakeDelightScene.gemmaVerde2 = lakeDelightScene.puzzleOverlay?.childNode(withName: "//GemmaVerde2") as? SKSpriteNode
        lakeDelightScene.gemmaVerde3 = lakeDelightScene.puzzleOverlay?.childNode(withName: "//GemmaVerde3") as? SKSpriteNode
        lakeDelightScene.gemmaViola1 = lakeDelightScene.puzzleOverlay?.childNode(withName: "//GemmaViola1") as? SKSpriteNode
        lakeDelightScene.gemmaViola2 = lakeDelightScene.puzzleOverlay?.childNode(withName: "//GemmaViola2") as? SKSpriteNode
        lakeDelightScene.gemmaViola3 = lakeDelightScene.puzzleOverlay?.childNode(withName: "//GemmaViola3") as? SKSpriteNode
        if let puzzleTitle = lakeDelightScene.puzzleOverlay?.childNode(withName: "//title") as? SKLabelNode {
            puzzleTitle.text = NSLocalizedString("PuzzleTitle", comment: "titolo")
        }
        if let puzzleDesc = lakeDelightScene.puzzleOverlay?.childNode(withName: "//desc") as? SKLabelNode {
            puzzleDesc.text = NSLocalizedString("PuzzleDescr", comment: "desc")
        }
        
        lakeDelightScene.changeGemTexture()
        lakeDelightScene.checkPuzzleSolution()
        
        }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        lakeDelightScene.audioInstance.backgroundMusicPlayer?.setVolume(0.8, fadeDuration: 0.5)
        lakeDelightScene.audioInstance.backgroundMusicPlayer2?.setVolume(0.0, fadeDuration: 0.5)
        
        lakeDelightScene.popUpShow = true
        
        lakeDelightScene.puzzleOverlay?.alpha = 0.0
        lakeDelightScene.puzzleShow = false
        lakeDelightScene.portal?.alpha = 1.0
        lakeDelightScene.eventMapNode3?.removeFromParent()
        if let button = lakeDelightScene.interactButton?.childNode(withName: "//interact_button") as? SKSpriteNode {
            button.alpha = 0.3
            button.texture = SKTexture.init(imageNamed: "pulsanteazione")
        }
    }
    
}
