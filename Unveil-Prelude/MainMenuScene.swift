//
//  MainMenuScene.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 18/02/22.
//

import Foundation
import SpriteKit
import GameplayKit

class MainMenuScene: SKScene {
    
    private var unveilLabel: SKLabelNode?
    private var buttonNode: SKShapeNode?
    private var tapToStartLabel: SKLabelNode?
    private var backgroundNode: SKSpriteNode?
    
    override func sceneDidLoad() {

        self.unveilLabel = self.childNode(withName: "unveilLabel") as? SKLabelNode
        self.buttonNode = self.childNode(withName: "ButtonNode") as? SKShapeNode
        self.tapToStartLabel = self.childNode(withName: "tapToStartLabel") as? SKLabelNode
        self.backgroundNode = self.childNode(withName: "backgroundNode") as? SKSpriteNode
        
        
    }
    
    
    
    }

