//
//  EndingScene.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 07/03/22.
//

import Foundation
import SpriteKit
import GameplayKit

class EndingScene: SKScene {
    
    private var firstLabel : SKLabelNode?
    private var subheadLabel : SKLabelNode?
    private var unveil: SKLabelNode?
    private var dragonflies: SKLabelNode?
    private var special: SKLabelNode?
    private var bgNode: SKSpriteNode?
    private var team: SKLabelNode?
    
    override func sceneDidLoad() {
        
        self.firstLabel = self.childNode(withName: "firstLabel") as? SKLabelNode
        if let firstLabel = self.firstLabel {
            firstLabel.text = NSLocalizedString("Thanksforplaying", comment: "Thanks")
            firstLabel.alpha = 0.0
            firstLabel.run(SKAction.fadeIn(withDuration: 2.0))
        }
        self.subheadLabel = self.childNode(withName: "subheadLabel") as? SKLabelNode
        if let subheadLabel = self.subheadLabel {
            subheadLabel.text = NSLocalizedString("thanksSubhead", comment: "subhead")
            
            subheadLabel.alpha = 0.0
            subheadLabel.run(SKAction.fadeIn(withDuration: 2.0))
        }
        self.unveil = self.childNode(withName: "unveil") as? SKLabelNode
        if let unvLabel = self.unveil {
            unvLabel.alpha = 0.0
            unvLabel.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.dragonflies = self.childNode(withName: "dragonflies") as? SKLabelNode
        if let dragLabel = self.dragonflies {
            dragLabel.alpha = 0.0
            dragLabel.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.special = self.childNode(withName: "special") as? SKLabelNode
        if let specialLabel = self.special {
            specialLabel.alpha = 0.0
            specialLabel.run(SKAction.fadeIn(withDuration: 2.0))
        }
        self.team = self.childNode(withName: "team") as? SKLabelNode
        if let teamlabel = self.team {
            teamlabel.alpha = 0.0
            teamlabel.run(SKAction.fadeIn(withDuration: 2.0))
        }
        self.bgNode = self.childNode(withName: "bgNode") as? SKSpriteNode
        
        
    }
    
    
    func sceneTouched(touchLocation:CGPoint) {
        if let label = self.firstLabel {
            label.run(SKAction.fadeOut(withDuration: 2.0))
        }
        if let label2 = self.subheadLabel {
            label2.run(SKAction.fadeOut(withDuration: 2.0))
        }
        if let unv = self.unveil {
            unv.run(SKAction.fadeOut(withDuration: 2.0))
        }
        if let drag = self.dragonflies {
            drag.run(SKAction.fadeOut(withDuration: 2.0))
        }
        if let spec = self.special {
            spec.run(SKAction.fadeOut(withDuration: 2.0))
        }
        if let team = self.team {
            team.run(SKAction.fadeOut(withDuration: 2.0))
        }
        
        if let nextScene = GKScene(fileNamed: "DemoLaunchScene") {
            if let nextSceneNode = nextScene.rootNode as! DemoLaunchScene? {
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
