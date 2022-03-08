//
//  LakeDelightScene.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 18/02/22.
//

import Foundation
import SpriteKit
import GameplayKit

class LakeDelightScene: SKScene, SKPhysicsContactDelegate {
    
    
    var dialogueManager: DialogueManager = DialogueManager()
    var scriptInstance: Script?
    var dialogueInstance: Dialogue?
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var audioInstance = SKTAudio.sharedInstance()
    
    private var lastUpdateTime : TimeInterval = 0
    private var player: Player?
    private var felicity: FelicityChar?
    private var takeo: TakeoChar?
    
    var GameStateMachine: GKStateMachine?
    
    private var mapLabel: SKLabelNode?
    var dialogueOverlay: SKNode?
    var frecciaDialogo: SKSpriteNode?
    var menuButton: SKSpriteNode?
    var menuOverlay: SKNode?
    var puzzleOverlay: SKNode?
    var questTitle: SKLabelNode?
    var questDescription: SKLabelNode?
    
    var controller: SKNode?
    var interactButton: SKNode?
    let margin: CGFloat = 20.0
    
    var lakeMapNode: SKTileMapNode?
    var eventMapNode: SKTileMapNode?
    var eventMapNode2: SKTileMapNode?
    var eventMapNode3: SKTileMapNode?
    var eventMapNode4: SKTileMapNode?
    
    var puzzleDialogEnabled: Bool = false
    var puzzleShow: Bool = false
    var cutScene: Bool = false
    var currentNode: SKSpriteNode?
    var startPosition: CGPoint?
    var gemmaRossa1: SKSpriteNode?
    var gemmaRossa2: SKSpriteNode?
    var gemmaRossa3: SKSpriteNode?
    var gemmaVerde1: SKSpriteNode?
    var gemmaVerde2: SKSpriteNode?
    var gemmaVerde3: SKSpriteNode?
    var gemmaViola1: SKSpriteNode?
    var gemmaViola2: SKSpriteNode?
    var gemmaViola3: SKSpriteNode?
    var portal: SKSpriteNode?
    var popUpShow: Bool = false
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        
        GameStateMachine = GKStateMachine(states: [GameStateActive(scene: self),GameStateDialogue(scene: self),GameStateMenu(scene: self),GameStatePuzzle(scene: self), GameStateDialogueEvent(scene: self), GameStateEndCut(scene: self)])
        GameStateMachine?.enter(GameStateActive.self)
        
        self.mapLabel = self.childNode(withName: "//mapLabel") as? SKLabelNode
        if let label = self.mapLabel {
            label.text = NSLocalizedString("Lake Delight", comment: "LaKe DeLiGhT")
            label.run(SKAction.fadeOut(withDuration: 2.0))
        }
        self.dialogueOverlay = childNode(withName: "//dialogueOveraly")
        self.interactButton = childNode(withName: "interact")
        self.controller = childNode(withName: "controller")
        self.menuButton = childNode(withName: "//menuButton") as? SKSpriteNode
        self.menuOverlay = childNode(withName: "//menuOverlay")
        self.questTitle = childNode(withName: "//questTitle") as? SKLabelNode
        self.questDescription = childNode(withName: "//questDescription") as? SKLabelNode
        self.puzzleOverlay = childNode(withName: "//puzzleOverlay")
        self.portal = childNode(withName: "Tearing") as? SKSpriteNode
        self.frecciaDialogo = childNode(withName: "//frecciaDialogo") as? SKSpriteNode
        if let freccetta = self.frecciaDialogo {
            freccetta.run(SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0.0, y: -10.0, duration: 0.5),SKAction.moveBy(x: 0.0, y: 10.0, duration: 0.5)])))
        }
        
    }
    
    override func didMove(to view: SKView) {
        audioInstance.playBackgroundMusic("LakeDelightTheme.mp3")
        audioInstance.backgroundMusicPlayer?.volume = 0.0
        audioInstance.backgroundMusicPlayer?.setVolume(0.8, fadeDuration: 0.5)
        audioInstance.playBackgroundMusic2("LakeDelightpuzzle.mp3")
        audioInstance.backgroundMusicPlayer2?.volume = 0.0
        
        physicsWorld.contactDelegate = self
        
        player = childNode(withName: "player") as? Player
        player?.physicsBody = player?.charPhysicsBody
        player?.physicsBody?.affectedByGravity = false
        player?.physicsBody?.allowsRotation = false
        player?.physicsBody?.pinned = false
        player?.physicsBody?.friction = 0.0
        player?.physicsBody?.restitution = 0.0
        player?.physicsBody?.linearDamping = 0.0
        player?.physicsBody?.angularDamping = 0.0
        player?.physicsBody?.categoryBitMask = 1
        player?.physicsBody?.collisionBitMask = 3
        player?.physicsBody?.contactTestBitMask = 4
        
        player?.move(.stop)
        player?.physicsBody?.contactTestBitMask = 4
        
        felicity = childNode(withName: "Felicity") as? FelicityChar
        felicity?.physicsBody = felicity?.charPhysicsBody
        felicity?.physicsBody?.affectedByGravity = false
        felicity?.physicsBody?.allowsRotation = false
        felicity?.physicsBody?.pinned = false
        felicity?.physicsBody?.friction = 0.0
        felicity?.physicsBody?.restitution = 0.0
        felicity?.physicsBody?.linearDamping = 0.0
        felicity?.physicsBody?.angularDamping = 0.0
        felicity?.physicsBody?.isDynamic = false
        felicity?.physicsBody?.categoryBitMask = 1
        felicity?.physicsBody?.collisionBitMask = 3
        felicity?.physicsBody?.contactTestBitMask = 4
        
        takeo = childNode(withName: "Takeo") as? TakeoChar
        takeo?.physicsBody = takeo?.charPhysicsBody
        takeo?.physicsBody?.affectedByGravity = false
        takeo?.physicsBody?.allowsRotation = false
        takeo?.physicsBody?.pinned = false
        takeo?.physicsBody?.friction = 0.0
        takeo?.physicsBody?.restitution = 0.0
        takeo?.physicsBody?.linearDamping = 0.0
        takeo?.physicsBody?.angularDamping = 0.0
        takeo?.physicsBody?.isDynamic = false
        takeo?.physicsBody?.categoryBitMask = 1
        takeo?.physicsBody?.collisionBitMask = 3
        takeo?.physicsBody?.contactTestBitMask = 4
        
        portal?.run(SKAction(named: "portalAnim")!)
        setupCamera()
        
        let grassMapNode = childNode(withName: "GrassMapNode") as? SKTileMapNode
        grassMapNode?.setupEdgeLoop()
        
        lakeMapNode = childNode(withName: "LakeMapNode") as? SKTileMapNode
        lakeMapNode?.setupMapPhysics()
        
        let bushMapNode = childNode(withName: "BushMapNode") as? SKTileMapNode
        bushMapNode?.setupMapPhysics()
        let bushMapNode2 = childNode(withName: "BushMapNode2") as? SKTileMapNode
        bushMapNode2?.setupMapPhysics()
        
        let treeMapNode = childNode(withName: "TreeMapNode") as? SKTileMapNode
        treeMapNode?.setupMapPhysics()
        let treeMapNode2 = childNode(withName: "TreeMapNode2") as? SKTileMapNode
        treeMapNode2?.setupMapPhysics()
        
        eventMapNode = childNode(withName: "EventTileMap1") as? SKTileMapNode
        eventMapNode?.setupEventMapPhysics(eventName: "event1")
        
        eventMapNode2 = childNode(withName: "EventTileMap2") as? SKTileMapNode
        eventMapNode2?.setupEventMapPhysics(eventName: "event2")
        
        eventMapNode3 = childNode(withName: "EventTileMap3") as? SKTileMapNode
        eventMapNode3?.setupEventMapPhysics(eventName: "event3")
        
        eventMapNode4 = childNode(withName: "EventTileMap4") as? SKTileMapNode
        eventMapNode4?.setupEventMapPhysics(eventName: "event4")
        
        if (GameStateMachine?.enter(GameStateDialogue.self)) != nil{
            //updateDialogue()
        }
    }
    
    func updateDialogue(){
        if let name = dialogueOverlay?.childNode(withName: "//SpeakerName") as? SKLabelNode {
            name.text = dialogueInstance?.speakerName
        }
        if let dialogue = dialogueOverlay?.childNode(withName: "//DialogueText") as? SKLabelNode {
            dialogue.text = dialogueInstance?.dialogueText
        }
        if let image = dialogueOverlay?.childNode(withName: "//SpeakerSprite") as? SKSpriteNode {
            if dialogueInstance?.speakerImg != "" {
                image.texture = SKTexture.init(imageNamed: dialogueInstance?.speakerImg ?? "")
            }else{
                image.texture = SKTexture.init()
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
        if let touchedNode = nodeAtPoint as? SKNode  {
            
            if (touchedNode as? SKSpriteNode)?.name?.starts(with: "controller_") == true {
                let direction = touchedNode.name?.replacingOccurrences(
                    of: "controller_", with: "")
                player?.move(Direction(rawValue: direction ?? "stop")!)
            }
            else if (touchedNode as? SKSpriteNode)?.name == "interact_button" {
                if puzzleDialogEnabled {
                    player?.interact()
                    audioInstance.playSoundEffect("dot.mp3")
                    
                    felicity?.run(SKAction(named: "FelicityWalkFrontAnim")!)
                    felicity?.run(SKAction.sequence([
                        SKAction.move(to: CGPoint(x: 80 - 54 , y: 48 + 8 ), duration: 2.0),
                                                      SKAction(named: "idleFelicity")!
                    ]))
                    
                    takeo?.run(SKAction(named: "TakeoWalkFrontAnim")!)
                    takeo?.run(SKAction.sequence([
                        SKAction.move(to: CGPoint(x: 80 - 74  , y: 48 - 20), duration: 2.0),
                                                      SKAction(named: "idleTakeo")!
                    ]))
                    GameStateMachine?.enter(GameStateDialogue.self)
                    puzzleDialogEnabled = false
                    puzzleShow = true
                }
            }
            else if (touchedNode as? SKSpriteNode)?.name == "menuButton" {
                audioInstance.playSoundEffect("dot.mp3")
                GameStateMachine?.enter(GameStateMenu.self)
            }
            else if (touchedNode as? SKSpriteNode)?.name == "closeButton" {
                audioInstance.playSoundEffect("dot.mp3")
                GameStateMachine?.enter(GameStateActive.self)
            }
            
            else if (
                (touchedNode as? SKSpriteNode)?.name == "DialogueBox" || (touchedNode as? SKLabelNode)?.name == "DialogueText" || (touchedNode as? SKSpriteNode)?.name == "frecciaDialogo" || (touchedNode as? SKSpriteNode)?.name == "SpeakerBox" || (touchedNode as? SKLabelNode)?.name == "SpeakerName") {
                audioInstance.playSoundEffect("dot.mp3")
                
                if let nextDialogue = scriptInstance?.getNextDialogue()  {
                    scriptInstance?.currentIndex += 1
                    dialogueInstance = nextDialogue
                    updateDialogue()
                }
                else {
                    GameStateMachine?.enter(GameStateActive.self)
                   // dialogueOverlay?.run(SKAction.fadeOut(withDuration: 1.0))
                    if puzzleShow {
                        GameStateMachine?.enter(GameStatePuzzle.self)
                        
                    }
                }
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
        
        if GameStateMachine?.currentState is GameStatePuzzle{
            
            if let touch = touches.first {
                let location = touch.location(in: self)
                let nodeAtPoint = atPoint(location)
                if let touchedNode = nodeAtPoint as? SKSpriteNode{
                    if touchedNode.name?.starts(with: "Gemma") == true {
                        print(touchedNode.position)
                        self.currentNode = touchedNode
                        self.currentNode?.zPosition = 100
                        self.startPosition = currentNode?.position
                    }
                }
            }
        }
            for t in touches { self.touchDown(atPoint: t.location(in: self))}
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if GameStateMachine?.currentState is GameStatePuzzle {
            if let touch = touches.first, let node = self.currentNode {
                let touchLocation = touch.location(in: self)
                node.position = touchLocation
                
            }
        }
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if GameStateMachine?.currentState is GameStatePuzzle {

            if let touch = touches.first {
                let location = touch.location(in: self)
                var foundYeOldSwitcheroo = false
                let touchedNodes = self.nodes(at: location)
                    for node in touchedNodes {
                        
                        if(node.name?.starts(with: "Gemma") == true && node.name != self.currentNode?.name){
                            
                            if let posizioneIniziale = startPosition {
                                
                                self.currentNode?.position = node.position
                                self.currentNode?.zPosition = 50
                                node.position = posizioneIniziale
                                foundYeOldSwitcheroo = true
                                
                            }
                            print("Cambia texture")
                            changeGemTexture()
                            
                            print("Check solution")
                            checkPuzzleSolution()
                            break
                        }
                        
                    }
                if !foundYeOldSwitcheroo {
                    self.currentNode?.position = startPosition!
                    self.currentNode?.zPosition = 50
                }
                
            }
            self.currentNode = nil
            self.startPosition = nil
        }
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if GameStateMachine?.currentState is GameStatePuzzle {
            let node = self.currentNode
            node?.position = startPosition!
            self.currentNode = nil
            self.startPosition = nil
        }
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
        
        controller?.position = CGPoint(x: (viewLeft  - margin-10 + insets.left),
                                       y: (viewBottom  + insets.bottom - margin/2 ))
        
        interactButton?.position = CGPoint(x: (viewRight + margin+10 - insets.right),
                                           y: (viewBottom + insets.bottom - margin/2))
    }
    
    func beginCollisionBetween(playerNode: SKNode, eventNode: SKNode) {
        
        if eventNode.name == "event1" {
            eventMapNode?.removeFromParent()
            player?.stop()
            GameStateMachine?.enter(GameStateDialogue.self)
            takeo?.position = CGPoint(x: -42, y: -32)
            takeo?.alpha = 1.0
            felicity?.alpha = 1.0
            takeo?.position = CGPoint(x: -16, y: -32)
            felicity?.move(.up, posX: (player?.position.x)! - 22, posY: (player?.position.y)!)
            takeo?.move(.up, posX: (player?.position.x)! - 48, posY: (player?.position.y)!)
            
            
        } else if eventNode.name == "event2" {
            doNotCrossBottomMap()
        }
        else if eventNode.name == "event3"{
            if DialogueManager.questPhase == .second  {
                if let button = interactButton?.childNode(withName: "//interact_button") as? SKSpriteNode {
                button.alpha = 1.0
                button.texture = SKTexture.init(imageNamed: "interactiontrue")
                puzzleDialogEnabled = true
                
            }
                
            }
        }
        else if eventNode.name == "event4" {
            if cutScene {
                GameStateMachine?.enter(GameStateEndCut.self)
                eventMapNode4?.removeFromParent()
                lakeMapNode?.removeAllChildren()
                
                player?.run(SKAction.sequence([
                    SKAction.move(to: CGPoint(x: -32, y: 100), duration: 1.0),
                    SKAction.run({self.player?.physicsBody?.velocity = CGVector(dx: 0, dy: 0)}) ,
                    SKAction.run {
                        self.audioInstance.playSoundEffect2("noise.mp3")
                        self.audioInstance.soundEffectPlayer2?.setVolume(0.03, fadeDuration: 5.0)
                    },
                    SKAction(named: "yamiFinal")!,
                    SKAction.run {
                        self.cutScene = false
                        DialogueManager.questPhase = .start
                        if let nextScene = GKScene(fileNamed: "BedroomScene") {
                            if let nextSceneNode = nextScene.rootNode as! BedroomScene? {
                                nextSceneNode.scaleMode = .aspectFill
                                self.view?.presentScene(nextSceneNode, transition: .fade(withDuration: 2.0))
                            }
                        }
                    }
                ]))
                felicity?.run(SKAction(named: "FelicityWalkBackAnim")!)
                felicity?.run(SKAction.sequence([
                    SKAction.move(to: CGPoint(x: 0.0 , y: 100-16  ), duration: 2.2),
                                                  SKAction(named: "idleFelicity")!
                ]))
                
                takeo?.run(SKAction(named: "TakeoWalkBackAnim")!)
                takeo?.run(SKAction.sequence([
                    SKAction.move(to: CGPoint(x: -64 , y: 100-16), duration: 2.0),
                                                  SKAction(named: "idleTakeo")!
                ]))
                
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        if nodeA.name == "player" {
            beginCollisionBetween(playerNode: nodeA, eventNode: nodeB)
        } else if nodeB.name == "player" {
            beginCollisionBetween(playerNode: nodeB, eventNode: nodeA)
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        if nodeA.name == "player" {
            endCollisionBetween(playerNode: nodeA, eventNode: nodeB)
        } else if nodeB.name == "player" {
            endCollisionBetween(playerNode: nodeB, eventNode: nodeA)
        }
    }
    
    func doNotCrossBottomMap(){
        player?.stop()
        GameStateMachine?.enter(GameStateDialogueEvent.self)
        player?.moveBackUp()
        
    }
    
    func endCollisionBetween(playerNode: SKNode, eventNode: SKNode){
        if eventNode.name == "event3" {
            if let button = interactButton?.childNode(withName: "//interact_button") as? SKSpriteNode {
            button.alpha = 0.3
            button.texture = SKTexture.init(imageNamed: "pulsanteazione")
            puzzleDialogEnabled = false
        }
            
        }
    }
    
    func changeGemTexture(){
//      Texture gemme Rosse

        if (gemmaRossa1?.position.x == -160.0){
            gemmaRossa1?.run(SKAction.sequence([SKAction(named: "RedTurningOn")!,SKAction(named: "RedFlashing")!]))
        }
        else{
            gemmaRossa1?.removeAllActions()
        }
        if (gemmaRossa2?.position.x == -160.0){
            gemmaRossa2?.run(SKAction.sequence([SKAction(named: "RedTurningOn")!,SKAction(named: "RedFlashing")!]))
        }
        else{
            gemmaRossa2?.removeAllActions()
        }
        if (gemmaRossa3?.position.x == -160.0){
            gemmaRossa3?.run(SKAction.sequence([SKAction(named: "RedTurningOn")!,SKAction(named: "RedFlashing")!]))
        }
        else{
            gemmaRossa3?.removeAllActions()
        }
        
//      Texture gemme Verdi
        if (gemmaVerde1?.position.x == 0.0){
            gemmaVerde1?.run(SKAction.sequence([SKAction(named: "GreenTurningOn")!,SKAction(named: "GreenFlashing")!]))
        }
        else{
            gemmaVerde1?.removeAllActions()
        }
        if (gemmaVerde2?.position.x == 0.0){
            gemmaVerde2?.run(SKAction.sequence([SKAction(named: "GreenTurningOn")!,SKAction(named: "GreenFlashing")!]))
        }
        else{
            gemmaVerde2?.removeAllActions()
        }
        if (gemmaVerde3?.position.x == 0.0){
            gemmaVerde3?.run(SKAction.sequence([SKAction(named: "GreenTurningOn")!,SKAction(named: "GreenFlashing")!]))
        }
        else{
            gemmaVerde3?.removeAllActions()
        }
//      Texture gemme Blu

        if (gemmaViola1?.position.x == 160.0){
            gemmaViola1?.run(SKAction.sequence([SKAction(named: "VioletTurningOn")!,SKAction(named: "VioletFlashing")!]))
        }
        else{
            gemmaViola1?.removeAllActions()
        }
        if (gemmaViola2?.position.x == 160.0){
            gemmaViola2?.run(SKAction.sequence([SKAction(named: "VioletTurningOn")!,SKAction(named: "VioletFlashing")!]))
        }
        else{
            gemmaViola2?.removeAllActions()
        }
        if (gemmaViola3?.position.x == 160.0){
            gemmaViola3?.run(SKAction.sequence([SKAction(named: "VioletTurningOn")!,SKAction(named: "VioletFlashing")!]))
        }
        else{
            gemmaViola3?.removeAllActions()
        }
        
    }
    
    func checkPuzzleSolution(){
//        Controllo delle posizioni di tutte le gemme
        
        print("Check interno solution")
        
        if (gemmaVerde1?.position.x == 0.0 && gemmaVerde2?.position.x == 0.0 && gemmaVerde3?.position.x == 0.0 &&
            gemmaRossa1?.position.x == -160.0 && gemmaRossa2?.position.x == -160.0 && gemmaRossa3?.position.x == -160.0)
        {
//          Cosa fare quando il puzzle è risolto
            print("risolto")
            
            if let compBlur = childNode(withName: "//CompBlur"){
                compBlur.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.8), SKAction.wait(forDuration: 2.0), SKAction.fadeOut(withDuration: 0.8) ,SKAction.run {
                    self.GameStateMachine?.enter(GameStateDialogue.self)
                }]))
                
            }
        }
        
    }
}
