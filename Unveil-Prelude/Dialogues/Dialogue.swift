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
let s3d1 = Dialogue(speakerName: "Felicity Wood", speakerImg: "3-Felicity-happy", dialogueText: NSLocalizedString("S3D1", comment: "Ciao Yami"))
let s3d2 = Dialogue(speakerName: "Felicity Wood", speakerImg: "3-Felicity-confused", dialogueText: NSLocalizedString("S3D2", comment: "Sei già qui"))

