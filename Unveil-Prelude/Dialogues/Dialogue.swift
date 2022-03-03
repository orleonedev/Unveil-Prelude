//
//  Dialogue.swift
//  Unveil-Prelude
//
//  Created by Oreste Leone on 28/02/22.
//

import Foundation

struct Dialogue {
    
    var speakerName: String
    var speakerImg: String
    var dialogueText: String
    
}



let s1d1 = Dialogue(speakerName: "Yami Akibara", speakerImg: "1-yami-think", dialogueText: NSLocalizedString("FirstDialogLine", comment: "Yami1"))
let s2d1 = Dialogue(speakerName: "", speakerImg: "", dialogueText: NSLocalizedString("S2D1", comment: "Eccoci"))
let s2d2 = Dialogue(speakerName: "Felicity Wood", speakerImg: "3-Felicity-happy", dialogueText: NSLocalizedString("S2D2", comment: "Ciao Yami"))
let s2d3 = Dialogue(speakerName: "Felicity Wood", speakerImg: "3-Felicity-confused", dialogueText: NSLocalizedString("S2D3", comment: "Sei già qui"))

let s2d4 = Dialogue(speakerName: "Takeo Akahiro", speakerImg: "2-Takeo-fun", dialogueText: NSLocalizedString("S2D4", comment: "orologio"))

let s2d5 = Dialogue(speakerName: "Yami Akibara", speakerImg: "1-yami-annoyed", dialogueText: NSLocalizedString("S2D5", comment: "ha-ah"))

let s2d6 = Dialogue(speakerName: "Felicity Wood", speakerImg: "3-Felicity-sad", dialogueText: NSLocalizedString("S2D6", comment: "finitela"))

let s2d7 = Dialogue(speakerName: "Yami Akibara", speakerImg: "1-yami-drooly", dialogueText: NSLocalizedString("S2D7", comment: "bbq"))

let s2d8 = Dialogue(speakerName: "Takeo Akahiro", speakerImg: "2-Takeo-serious", dialogueText: NSLocalizedString("S2D8", comment: "ma magn semp"))

let s2d9 = Dialogue(speakerName: "Felicity Wood", speakerImg: "3-Felicity-confused", dialogueText: NSLocalizedString("S2D9", comment: "guardiamo attorno"))

let s2d10 = Dialogue(speakerName: "Yami Akibara", speakerImg: "1-yami-normal", dialogueText: NSLocalizedString("S2D10", comment: "proprio li"))


let uponBottomMarginDialogue: Dialogue = Dialogue(speakerName: "Yami Akibara", speakerImg: "1-yami-think", dialogueText: NSLocalizedString("doNotCrossBottom", comment: "turn aret"))
let uponBottomMarginDialogue2: Dialogue = Dialogue(speakerName: "Felicity Wood", speakerImg: "3-Felicity-confused", dialogueText: NSLocalizedString("doNotCrossBottom2", comment: "turn aret"))
let uponBottomMarginDialogue3: Dialogue = Dialogue(speakerName: "Takeo Akahiro", speakerImg: "2-Takeo-serious", dialogueText: NSLocalizedString("doNotCrossBottom3", comment: "turn aret"))
