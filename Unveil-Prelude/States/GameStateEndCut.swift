//
//  GameStateEndCut.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 06/03/22.
//

import Foundation
import GameplayKit

class GameStateEndCut : GKState {
    
    unowned var lakeDelightScene: LakeDelightScene
    
    init(scene: LakeDelightScene){
        self.lakeDelightScene = scene
        super.init()
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is GameStateActive.Type
    }
    
    override func didEnter(from previousState: GKState?) {
        print("Stato Explorative")
        lakeDelightScene.menuButton?.alpha = 0.0
        lakeDelightScene.controller?.alpha = 0.0
        lakeDelightScene.interactButton?.alpha = 0.0
        
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
       
    }
}
