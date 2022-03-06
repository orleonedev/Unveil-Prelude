//
//  BedroomScene.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 07/03/22.
//

import Foundation
import SpriteKit
import GameplayKit

class BedroomScene: SKScene {
    
    override func sceneDidLoad() {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    func sceneTouched(touchLocation:CGPoint) {
        
        if let nextScene = GKScene(fileNamed: "MainMenuScene") {
            if let nextSceneNode = nextScene.rootNode as! MainMenuScene? {
                nextSceneNode.scaleMode = .aspectFill
                view?.presentScene(nextSceneNode, transition: .fade(withDuration: 2.0))
            }
        }
        
    }
}
