//
//  DialogueManager.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 28/02/22.
//

import Foundation
import GameplayKit

enum QuestPhase: Int {
    case start = 0, second,third
}

struct Script {
    
    var dialoguesStore: [Dialogue]
    
    init(){
        self.dialoguesStore = [
            Dialogue(speakerName: "Yami Akibara", speakerImg: "Yami-Pensieroso", dialogueText: NSLocalizedString("FirstDialogLine", comment: "Yami1"))
        ]
    }
    
    func getDialogue(numb: Int)-> Dialogue{
        return dialoguesStore[numb]
    }
}

class DialogueManager {
    
    var scriptStore: [Script]
    
    init(){
        self.scriptStore = [Script()]
    }
    
    func getScript(numb: Int)-> Script{
        return scriptStore[numb]
    }
}
