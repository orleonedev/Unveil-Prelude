//
//  DemoLaunchView.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 18/02/22.
//

import Foundation
import SpriteKit
import GameplayKit

class DemoLaunchScene: SKScene {
    
    private var firstLabel : SKLabelNode?
    private var subheadLabel : SKLabelNode?
    private var bgNode: SKSpriteNode?
    
    override func sceneDidLoad() {
        
        self.firstLabel = self.childNode(withName: "firstLabel") as? SKLabelNode
        if let firstLabel = self.firstLabel {
            firstLabel.text = NSLocalizedString("This is a Demo Version of Un:Veil", comment: "Demo Version")
            firstLabel.alpha = 0.0
            firstLabel.run(SKAction.fadeIn(withDuration: 1.0))
        }
        self.subheadLabel = self.childNode(withName: "subheadLabel") as? SKLabelNode
        if let subheadLabel = self.subheadLabel {
            subheadLabel.text = NSLocalizedString("SubheadDemoLine", comment: "subhead")
            
            subheadLabel.alpha = 0.0
            subheadLabel.run(SKAction.fadeIn(withDuration: 1.0))
        }
        self.bgNode = self.childNode(withName: "bgNode") as? SKSpriteNode
        
    }
    
    
    func sceneTouched(touchLocation:CGPoint) {
        if let label = self.firstLabel {
            label.run(SKAction.fadeOut(withDuration: 1.0))
        }
        if let label2 = self.subheadLabel {
            label2.run(SKAction.fadeOut(withDuration: 1.0))
        }
        if let nextScene = GKScene(fileNamed: "MainMenuScene") {
            if let nextSceneNode = nextScene.rootNode as! MainMenuScene? {
                nextSceneNode.scaleMode = .aspectFill
                view?.presentScene(nextSceneNode, transition: .fade(withDuration: 2.0))
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLocation: touchLocation)
    }
    
}
