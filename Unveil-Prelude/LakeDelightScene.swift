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
    
    let activeState = GameStateActive()
    let dialogueState = GameStateDialogue()
    let menuState = GameStateMenu()
    
    
    
    
    let margin: CGFloat = 20.0
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
    }
    
    override func didMove(to view: SKView) {
        
        GameStateMachine = GKStateMachine(states: [activeState,dialogueState,menuState])
        GameStateMachine?.enter(GameStateActive.self)
        
        
        player = childNode(withName: "player") as? Player
        player?.move(.stop)
        
        
        setupCamera()
        
        let grassMapNode = childNode(withName: "GrassMapNode") as? SKTileMapNode
        grassMapNode?.setupEdgeLoop()
        
        let lakeMapNode = childNode(withName: "LakeMapNode") as? SKTileMapNode
        lakeMapNode?.setupMapPhysics()
    }
    
    func setupCamera() {
        guard let player = player else { return }
        let distance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(distance, to: player)
        
        camera?.constraints = [playerConstraint]
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
              let nodeAtPoint = atPoint(pos)
              if let touchedNode = nodeAtPoint as? SKSpriteNode {
                if touchedNode.name?.starts(with: "controller_") == true {
                  let direction = touchedNode.name?.replacingOccurrences(
                    of: "controller_", with: "")
                  player?.move(Direction(rawValue: direction ?? "stop")!)
                } else if touchedNode.name == "button_attack" {
                  player?.attack()
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
              let controller = childNode(withName: "//controller")
              controller?.position = CGPoint(x: (viewLeft  - margin + insets.left),
                                             y: (viewBottom  + insets.bottom - margin/2 ))
        
//              let attackButton = childNode(withName: "//attackButton")
//              attackButton?.position = CGPoint(x: (viewRight - margin - insets.right),
//                                               y: (viewBottom + margin + insets.bottom))
    }
}
