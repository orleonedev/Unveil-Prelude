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
    var skip: Bool = false
    var dialogue: Dialogue = Dialogue(speakerName: "Yami Akibara", speakerImg: "1-yami-think", dialogueText: NSLocalizedString("endCut", comment: "woah"))
    var frecciaDialogo: SKSpriteNode?
    var bedroom: SKSpriteNode?
    
    override func sceneDidLoad() {
        
        
        dialogueOverlay = childNode(withName: "//dialogueNode")
        
        if let speakerName = childNode(withName: "//SpeakerName") as? SKLabelNode {
            speakerName.text = ""
        }
        if let dialogueText = childNode(withName: "//DialogueText") as? SKLabelNode {
            dialogueText.text = "..."
        }
        if let image = childNode(withName: "//SpeakerSprite") as? SKSpriteNode {
            image.texture = SKTexture.init(imageNamed: "transparent" )
        }
        self.frecciaDialogo = childNode(withName: "//frecciaDialogo") as? SKSpriteNode
        if let freccetta = self.frecciaDialogo {
            freccetta.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0.0, y: -10.0, duration: 0.5),SKAction.moveBy(x: 0.0, y: 10.0, duration: 0.5)])))
        }
        
        bedroom = childNode(withName: "bedroom") as? SKSpriteNode
        
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
        
        if !skip {
            if let bedroomSprite = self.bedroom {
                bedroomSprite.run(SKAction.sequence([
                    SKAction.run {
                        self.dialogueOverlay?.run(SKAction.fadeOut(withDuration: 0.5))
                        self.bedroom?.texture = SKTexture(imageNamed: "stanzaocchiaperti")
                    } , SKAction.wait(forDuration: 1.0),
                    SKAction.run {
                        self.dialogueOverlay?.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.5)]))
                        if let speakerName = self.childNode(withName: "//SpeakerName") as? SKLabelNode {
                            speakerName.text = self.dialogue.speakerName
                        }
                        if let dialogueText = self.childNode(withName: "//DialogueText") as? SKLabelNode {
                            dialogueText.text = self.dialogue.dialogueText
                        }
                        if let image = self.childNode(withName: "//SpeakerSprite") as? SKSpriteNode {
                            image.texture = SKTexture.init(imageNamed: self.dialogue.speakerImg )
                        }
                    }
                ]))
            }
            skip = true
        }
        
        else {
            if let nextScene = GKScene(fileNamed: "EndingScene") {
                if let nextSceneNode = nextScene.rootNode as! EndingScene? {
                    nextSceneNode.scaleMode = .aspectFill
                    view?.presentScene(nextSceneNode, transition: .fade(withDuration: 2.0))
                }
            }

        }
                
    }
}
