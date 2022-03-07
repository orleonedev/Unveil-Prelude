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
    
    var audioInstance = SKTAudio.sharedInstance()
    var dialogueOverlay: SKNode?
    var dialogue: Dialogue = Dialogue(speakerName: "Yami Akibara", speakerImg: "1-yami-think", dialogueText: NSLocalizedString("endCut", comment: "woah"))
    var frecciaDialogo: SKSpriteNode?
    
    override func sceneDidLoad() {
        
        
        dialogueOverlay = childNode(withName: "//dialogueNode")
        
        if let speakerName = childNode(withName: "//SpeakerName") as? SKLabelNode {
            speakerName.text = dialogue.speakerName
        }
        if let dialogueText = childNode(withName: "//DialogueText") as? SKLabelNode {
            dialogueText.text = dialogue.dialogueText
        }
        if let image = childNode(withName: "//SpeakerSprite") as? SKSpriteNode {
            image.texture = SKTexture.init(imageNamed: dialogue.speakerImg )
        }
        self.frecciaDialogo = childNode(withName: "//frecciaDialogo") as? SKSpriteNode
        if let freccetta = self.frecciaDialogo {
            freccetta.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0.0, y: -10.0, duration: 0.5),SKAction.moveBy(x: 0.0, y: 10.0, duration: 0.5)])))
        }
    }
    
    override func didMove(to view: SKView) {
        
        
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
        
        if dialogueOverlay?.alpha == 0.0 {
            dialogueOverlay?.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.5)]))
        }
        
        else {
            if let nextScene = GKScene(fileNamed: "MainMenuScene") {
                if let nextSceneNode = nextScene.rootNode as! MainMenuScene? {
                    nextSceneNode.scaleMode = .aspectFill
                    view?.presentScene(nextSceneNode, transition: .fade(withDuration: 2.0))
                }
            }

        }
                
    }
}
