//
//  TakeoChar.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 03/03/22.
//


import SpriteKit
import GameplayKit
import Foundation

class TakeoChar: SKSpriteNode {
    
    private var walkBackAnimTakeo: SKAction = SKAction(named: "TakeoWalkBackAnim")!
    private var idleAnimTakeo: SKAction = SKAction(named: "Idle")!
//    private var idleAnimYami: SKAction = SKAction(named: "Idle")!
//    private var walkFrontAnimYami: SKAction = SKAction(named: "walkFrontAnim")!
//    private var walkBackAnimYami: SKAction = SKAction(named: "walkBackAnim")!
//    private var walkRightAnimYami: SKAction = SKAction(named: "walkRightAnim")!
//    private var walkLeftAnimYami: SKAction = SKAction(named: "walkLeftAnim")!
    private var currentDirection = Direction.stop
    private var isIdle: Bool = true
    
    func move(_ direction: Direction, posX: CGFloat, posY: CGFloat) {
        
        
        switch direction {
        case .up:
//            self.alpha = 1.0
            self.removeAllActions()
            self.isIdle = false
            self.run(walkBackAnimTakeo, withKey: "walkBackAnim")
            let moveY = SKAction.moveTo(y: posY, duration: 2.0)
            let moveX = SKAction.moveTo(x: posX, duration: 1.0)
            self.run(SKAction.sequence([moveX,moveY,idleAnimTakeo]))
//
//            self.run(SKAction.moveTo(x: posX, duration: 1.0))
//            self.run(SKAction.moveTo(y: posY, duration: 2.0))
        case .down:
            self.removeAllActions()
            self.isIdle = false
//            self.run(walkFrontAnimYami, withKey: "walkFrontAnim")
//            self.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
        case .left:
            self.removeAllActions()
            self.isIdle = false
//            self.run(walkLeftAnimYami, withKey: "walkSideAnim")
//            self.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
        case .right:
            self.removeAllActions()
            self.isIdle = false
//            self.run(walkRightAnimYami, withKey: "walkRightAnim")
//            self.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
        case .topLeft:
            if isIdle{
                self.removeAllActions()
//                self.run(walkBackAnimYami, withKey: "walkBackAnim")
            }
//            self.physicsBody?.velocity = CGVector(dx: -40, dy: 40)
            
        case .topRight:
            if isIdle{
                self.removeAllActions()
//                self.run(walkBackAnimYami, withKey: "walkBackAnim")
            }
//            self.physicsBody?.velocity = CGVector(dx: 40, dy: 40)
            
        case .bottomLeft:
            if isIdle{
                self.removeAllActions()
                self.isIdle = false
//                self.run(walkFrontAnimYami, withKey: "walkFrontAnim")
            }
//            self.physicsBody?.velocity = CGVector(dx: -40, dy: -40)
            
        case .bottomRight:
            if isIdle{
                self.removeAllActions()
                self.isIdle = false
//                self.run(walkFrontAnimYami, withKey: "walkFrontAnim")
            }
//            self.physicsBody?.velocity = CGVector(dx: 40, dy: -40)
            
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
//        self.run(idleAnimYami, withKey: "AnimIdle")
    }
    
    
}
