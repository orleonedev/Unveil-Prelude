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
  private var currentDirection = Direction.stop
  
  func move(_ direction: Direction) {
    print("move player: \(direction.rawValue)")
      self.run(walkFrontAnimYami, withKey: "walkFrontAnim")
    switch direction {
    case .up:
      self.physicsBody?.velocity = CGVector(dx: 0, dy: 50)
      //self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
    //self.physicsBody?.applyForce(CGVector(dx: 0, dy: 100))
    case .down:
      self.physicsBody?.velocity = CGVector(dx: 0, dy: -50)
    case .left:
      self.physicsBody?.velocity = CGVector(dx: -50, dy: 0)
    case .right:
      self.physicsBody?.velocity = CGVector(dx: 50, dy: 0)
    case .topLeft:
      self.physicsBody?.velocity = CGVector(dx: -50, dy: 50)
    case .topRight:
      self.physicsBody?.velocity = CGVector(dx: 50, dy: 50)
    case .bottomLeft:
      self.physicsBody?.velocity = CGVector(dx: -50, dy: -50)
    case .bottomRight:
      self.physicsBody?.velocity = CGVector(dx: 50, dy: -50)
    case .stop:
      stop()
    }
    
    if direction != .stop {
      currentDirection = direction
    }
  }
  
  func stop() {
    self.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
      self.run(idleAnimYami, withKey: "AnimIdle")
  }
  
  func attack() {
//    let projectile = SKSpriteNode(imageNamed: "knife")
//    projectile.position = CGPoint(x: 0.0, y: 0.0)
//    addChild(projectile)
//
//    var throwDirection = CGVector(dx: 0, dy: 0)
//
//    switch currentDirection {
//    case .up:
//      throwDirection = CGVector(dx: 0, dy: 300)
//      projectile.zRotation = 0
//    case .down:
//      throwDirection = CGVector(dx: 0, dy: -300)
//      projectile.zRotation = -CGFloat.pi
//    case .left:
//      throwDirection = CGVector(dx: -300, dy: 0)
//      projectile.zRotation = CGFloat.pi/2
//    case .right, .stop: // default pre-movement (throw right)
//      throwDirection = CGVector(dx: 300, dy: 0)
//      projectile.zRotation = -CGFloat.pi/2
//    case .topLeft:
//      throwDirection = CGVector(dx: -300, dy: 300)
//      projectile.zRotation = CGFloat.pi/4
//    case .topRight:
//      throwDirection = CGVector(dx: 300, dy: 300)
//      projectile.zRotation = -CGFloat.pi/4
//    case .bottomLeft:
//      throwDirection = CGVector(dx: -300, dy: -300)
//      projectile.zRotation = 3 * CGFloat.pi/4
//    case .bottomRight:
//      throwDirection = CGVector(dx: 300, dy: -300)
//      projectile.zRotation = 3 * -CGFloat.pi/4
//    }
//
//    let throwProjectile = SKAction.move(by: throwDirection, duration: 0.25)
//    projectile.run(throwProjectile,
//                   completion: {projectile.removeFromParent()})
  }
}

