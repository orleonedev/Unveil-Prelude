//
//  Player.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 18/02/22.
//

import Foundation
import SpriteKit
import GameplayKit

enum Direction: String {
    case stop
    case left
    case right
    case up
    case down
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

class Player: SKSpriteNode {
    
    private var idleAnimYami: SKAction = SKAction(named: "Idle")!
    private var walkFrontAnimYami: SKAction = SKAction(named: "walkFrontAnim")!
    private var walkBackAnimYami: SKAction = SKAction(named: "walkBackAnim")!
    private var walkRightAnimYami: SKAction = SKAction(named: "walkRightAnim")!
    private var walkLeftAnimYami: SKAction = SKAction(named: "walkLeftAnim")!
    private var currentDirection = Direction.stop
    private var isIdle: Bool = true
    let charPhysicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 18) ,center: CGPoint(x: 0.0 , y: -4.0))
    
    func move(_ direction: Direction) {
        print("move player: \(direction.rawValue)")
        
        switch direction {
        case .up:
            self.removeAllActions()
            self.isIdle = false
            self.run(walkBackAnimYami, withKey: "walkBackAnim")
            self.physicsBody?.velocity = CGVector(dx: 0, dy: 50)
        case .down:
            self.removeAllActions()
            self.isIdle = false
            self.run(walkFrontAnimYami, withKey: "walkFrontAnim")
            self.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
        case .left:
            self.removeAllActions()
            self.isIdle = false
            self.run(walkLeftAnimYami, withKey: "walkSideAnim")
            self.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
        case .right:
            self.removeAllActions()
            self.isIdle = false
            self.run(walkRightAnimYami, withKey: "walkRightAnim")
            self.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
        case .topLeft:
            if isIdle{
                self.removeAllActions()
                self.run(walkBackAnimYami, withKey: "walkBackAnim")
            }
            self.physicsBody?.velocity = CGVector(dx: -40, dy: 40)
            
        case .topRight:
            if isIdle{
                self.removeAllActions()
                self.run(walkBackAnimYami, withKey: "walkBackAnim")
            }
            self.physicsBody?.velocity = CGVector(dx: 40, dy: 40)
            
        case .bottomLeft:
            if isIdle{
                self.removeAllActions()
                self.isIdle = false
                self.run(walkFrontAnimYami, withKey: "walkFrontAnim")
            }
            self.physicsBody?.velocity = CGVector(dx: -40, dy: -40)
            
        case .bottomRight:
            if isIdle{
                self.removeAllActions()
                self.isIdle = false
                self.run(walkFrontAnimYami, withKey: "walkFrontAnim")
            }
            self.physicsBody?.velocity = CGVector(dx: 40, dy: -40)
            
        case .stop:
            stop()
        }
        
        if direction != .stop {
            currentDirection = direction
        }
    }
    
    func stop() {
        self.removeAllActions()
        self.isIdle = true
        self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.run(idleAnimYami, withKey: "AnimIdle")
    }
    
    func interact() {
        print("interact")
    }
    
    func moveBackUp() {
        self.removeAllActions()
        self.isIdle = false
        self.run(walkBackAnimYami, withKey: "walkBackAnim")
        self.run(SKAction.sequence([SKAction.moveBy(x: 0.0, y: +32, duration: 1.0), idleAnimYami]))
    }
}

