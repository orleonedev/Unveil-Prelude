//
//  GameStateMenu.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 22/02/22.
//

import Foundation
import GameplayKit

class GameStateMenu: GKState {
    
    unowned var lakeDelightScene: LakeDelightScene
    
    init(scene: LakeDelightScene){
        self.lakeDelightScene = scene
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameStateActive.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        print("menuState")
        lakeDelightScene.menuOverlay?.alpha = 1.0
        lakeDelightScene.questTitle?.text = NSLocalizedString("Quest1", comment: "QuestTitle1")
        
        switch DialogueManager.questPhase{
        case .start:
            lakeDelightScene.questDescription?.text = NSLocalizedString("Quest1Description", comment: "phase1")
        case .first:
            lakeDelightScene.questDescription?.text = NSLocalizedString("Quest1Description", comment: "phase1")
        case .second:
            lakeDelightScene.questDescription?.text = NSLocalizedString("Quest2Description", comment: "phase2")
        //case .third:
       //     lakeDelightScene.questDescription?.text = NSLocalizedString("Quest3Description", comment: "phase3")
            
        }
        
        }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        lakeDelightScene.menuOverlay?.alpha = 0.0
    }
    
}
