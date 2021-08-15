//
//  PoppingService.swift
//  PoppingService
//
//  Created by Linus Skucas on 8/14/21.
//

import Foundation
import AVFoundation

@objc class PoppingService: NSObject, PoppingServiceProtocol {
    var popSound: AVAudioPlayer!
    var frogSound: AVAudioPlayer!
    var mooSound: AVAudioPlayer!
    
    override init() {
        super.init()
        let poppingURL = URL(fileURLWithPath: "/Library/PreferencePanes/KeyPopper PrefPane.prefPane/Contents/Resources/pop.mp3")
        let mooingURL = URL(fileURLWithPath: "/Library/PreferencePanes/KeyPopper PrefPane.prefPane/Contents/Resources/moo.mp3")
        let frogingURL = URL(fileURLWithPath: "/Library/PreferencePanes/KeyPopper PrefPane.prefPane/Contents/Resources/frog.mp3")
        
        popSound = try! AVAudioPlayer(contentsOf: poppingURL)
        popSound.volume = 1.00
        popSound.prepareToPlay()
        mooSound = try! AVAudioPlayer(contentsOf: mooingURL)
        mooSound.volume = 1.00
        mooSound.prepareToPlay()
        frogSound = try! AVAudioPlayer(contentsOf: frogingURL)
        frogSound.volume = 1.00
        frogSound.prepareToPlay()
    }
    
    func pop() {
        DispatchQueue.main.async {
            self.popSound.play()
        }
    }
    
    func frog() {
        DispatchQueue.main.async {
            self.frogSound.play()
        }
    }
    
    func moo() {
        DispatchQueue.main.async {
            self.mooSound.play()
        }
    }
}
