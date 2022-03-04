//
//  DialogueManager.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 28/02/22.
//

import Foundation
import GameplayKit

enum QuestPhase: Int, CaseIterable {
    case start = 0, first, second, third
//         fourth
    
    mutating func next() {
            let allCases = type(of: self).allCases
        self = allCases[(allCases.firstIndex(of: self)! + 1) % allCases.count]
        }
}



struct Script {
    
    var currentIndex: Int = 0
    var dialoguesStore: [Dialogue]
    
    init(dialogues:[Dialogue]){
        self.dialoguesStore = dialogues
    }
    
    func getDialogue(numb: Int)-> Dialogue?{
        return dialoguesStore[numb]
    }
    
    func getNextDialogue() -> Dialogue? {
        if currentIndex != dialoguesStore.endIndex-1 {
            return getDialogue(numb: currentIndex+1)
        }
        else {
            return nil
        }
    }
    
}

let script1 = Script(dialogues: [s1d1])
let script2 = Script(dialogues: [s2d1, s2d2, s2d3, s2d4, s2d5, s2d6, s2d7, s2d8, s2d9, s2d10])
let script3 = Script(dialogues: [s3d1, s3d2, s3d3, s3d4])
//let script4 = Script(dialogues: [])

class DialogueManager {
    
    static var questPhase: QuestPhase = QuestPhase.start
    var scriptStore: [Script]
    
    init(){
        
        self.scriptStore = [script1,script2,script3]
    }
    
    func getScript(numb: QuestPhase)-> Script{
        return scriptStore[numb.rawValue]
    }
    
    func getNextScript()-> Script {
        return getScript(numb: DialogueManager.questPhase)
    }
    
}




