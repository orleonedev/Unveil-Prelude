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
    private var tapToStartLabel: SKLabelNode?
    private var mainMenuImage: SKSpriteNode?
    
    override func sceneDidLoad() {
        
        SKTAudio.sharedInstance().backgroundMusicPlayer?.volume = 0.0
        SKTAudio.sharedInstance().playBackgroundMusic("Mysterio.mp3")
        SKTAudio.sharedInstance().backgroundMusicPlayer?.setVolume(0.6, fadeDuration: 1.0)
        self.unveilLabel = self.childNode(withName: "unveilLabel") as? SKLabelNode
        self.tapToStartLabel = self.childNode(withName: "tapToStartLabel") as? SKLabelNode
        if let taplabel = self.tapToStartLabel {
            taplabel.text = NSLocalizedString("Tap To Start", comment: "tap")
            taplabel.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 1.5), SKAction.fadeIn(withDuration: 1.5)])))
        }
        if let blur2 = self.childNode(withName: "//blur2") as? SKSpriteNode{
            blur2.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeAlpha(to: 0.0, duration: 1.5), SKAction.fadeAlpha(to: 0.4, duration: 1.5)])))
        }
        self.mainMenuImage = self.childNode(withName: "MainMenuImage") as? SKSpriteNode
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
    
    func sceneTouched(touchLocation:CGPoint) {
//        let nodeAtPoint = atPoint(touchLocation)
//        if let touchedNode = nodeAtPoint as? SKLabelNode {
//            if touchedNode.name?.starts(with: "tapToStart") == true{
        SKTAudio.sharedInstance().backgroundMusicPlayer?.stop()
                if let nextScene = GKScene(fileNamed: "LakeDelightScene") {
                    if let nextSceneNode = nextScene.rootNode as! LakeDelightScene? {
                        nextSceneNode.scaleMode = .resizeFill
                        view?.presentScene(nextSceneNode, transition: .fade(withDuration: 2.0))
                    }
                }
//            }
//        }
    }
}
