//
//  LakeDelightScene.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 18/02/22.
//

import Foundation
import SpriteKit
import GameplayKit

class LakeDelightScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var player: Player?
    
    
    
    var GameStateMachine: GKStateMachine?
    
    private var mapLabel: SKLabelNode?
    private var dialogueOverlay: SKNode?
    
    
    
    let margin: CGFloat = 20.0
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        GameStateMachine = GKStateMachine(states: [GameStateActive(),GameStateDialogue(),GameStateMenu()])
        GameStateMachine?.enter(GameStateActive.self)
        
        self.mapLabel = self.childNode(withName: "//mapLabel") as? SKLabelNode
        if let label = self.mapLabel {
            label.text = NSLocalizedString("Lake Delight", comment: "LaKe DeLiGhT")
            label.run(SKAction.fadeOut(withDuration: 1.0))
        }
        
    }
    
    override func didMove(to view: SKView) {
        
        
        player = childNode(withName: "player") as? Player
        player?.move(.stop)
        
        
        setupCamera()
        
        let grassMapNode = childNode(withName: "GrassMapNode") as? SKTileMapNode
        grassMapNode?.setupEdgeLoop()
        
        let lakeMapNode = childNode(withName: "LakeMapNode") as? SKTileMapNode
        lakeMapNode?.setupMapPhysics()
        
        if (GameStateMachine?.enter(GameStateDialogue.self)) != nil{
            dialogueOverlay = childNode(withName: "//dialogueOveraly")
            dialogueOverlay?.alpha = 1.0
            if let name = dialogueOverlay?.childNode(withName: "//SpeakerName") as? SKLabelNode {
                name.text = NSLocalizedString("YamiName", comment: "YamiName")
            }
            if let dialogue = dialogueOverlay?.childNode(withName: "//DialogueText") as? SKLabelNode {
                dialogue.text = NSLocalizedString("FirstDialogLine", comment: "firstLine")
            }
            if let image = dialogueOverlay?.childNode(withName: "//SpeakerSprite") as? SKSpriteNode {
                image.texture = SKTexture.init(imageNamed: "Yami-Pensieroso")
            }
            
        }
    }
    
    func setupCamera() {
        guard let player = player else { return }
        let distance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(distance, to: player)
        
        camera?.constraints = [playerConstraint]
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
              let nodeAtPoint = atPoint(pos)
              if let touchedNode = nodeAtPoint as? SKNode {
                  
                  if (touchedNode as? SKSpriteNode)?.name?.starts(with: "controller_") == true {
                  let direction = touchedNode.name?.replacingOccurrences(
                    of: "controller_", with: "")
                  player?.move(Direction(rawValue: direction ?? "stop")!)
                }
                  else if (touchedNode as? SKSpriteNode)?.name == "interact_button" {
                  player?.interact()
                }
                  else if (
                    (touchedNode as? SKShapeNode)?.name == "DialogueBox" || (touchedNode as? SKLabelNode)?.name == "DialogueText") {
                      GameStateMachine?.enter(GameStateActive.self)
                      dialogueOverlay?.run(SKAction.fadeOut(withDuration: 0.25))
                      
                  }
              }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
              let nodeAtPoint = atPoint(pos)
              if let touchedNode = nodeAtPoint as? SKSpriteNode {
                if touchedNode.name?.starts(with: "controller_") == true {
                  let direction = touchedNode.name?.replacingOccurrences(
                    of: "controller_", with: "")
                  player?.move(Direction(rawValue: direction ?? "stop")!)
                }
              }
    }
    
    func touchUp(atPoint pos : CGPoint) {
              let nodeAtPoint = atPoint(pos)
              if let touchedNode = nodeAtPoint as? SKSpriteNode {
                if touchedNode.name?.starts(with: "controller_") == true {
                  player?.stop()
                }
              }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
    
    override func didFinishUpdate() {
        updateControllerLocation()
    }
    
    func updateControllerLocation() {
        let controller: SKNode? = childNode(withName: "controller")
        let interactButton: SKNode? = childNode(withName: "interact")
        if GameStateMachine?.currentState is GameStateActive
             {
//            controller = childNode(withName: "controller")
            controller?.alpha = 1.0
            interactButton?.alpha = 1.0
              controller?.position = CGPoint(x: (viewLeft  - margin-10 + insets.left),
                                             y: (viewBottom  + insets.bottom - margin/2 ))
        
//              interactButton = childNode(withName: "interact")
              interactButton?.position = CGPoint(x: (viewRight + margin+10 - insets.right),
                                               y: (viewBottom + insets.bottom - margin/2))
            
        }
        else{
            controller?.alpha = 0.0
            interactButton?.alpha = 0.0
            
        }
    }
}
