//
//  GoogleSpeech.swift
//  Footprint
//
//  Created by Jing Lin on 2/17/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import AVFoundation

let synth = AVSpeechSynthesizer()

func processString(html_string: String) {
    synth.stopSpeaking(at: AVSpeechBoundary.immediate)
    let htmlData = NSString(string: html_string).data(using: String.Encoding.unicode.rawValue)
    let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
        NSAttributedString.DocumentType.html]
    let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(), options: options, documentAttributes: nil)
    
    let utterance = AVSpeechUtterance(attributedString: attributedString!)
    //        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
    let lang = "en-US"
    
    utterance.voice = AVSpeechSynthesisVoice(language: lang)
    synth.speak(utterance)
}
