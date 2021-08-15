//
//  KettleCornService.swift
//  KettleCornService
//
//  Created by Linus Skucas on 8/3/21.
//

import Foundation

struct SoundState {
    private let userDefaults = UserDefaults.init(suiteName: "sh.linus.keypopper")!
    
    var sound: PoppingSounds {
        get {
            let soundInt = userDefaults.integer(forKey: "sound")
            let sound = PoppingSounds(rawValue: soundInt)!
            return sound
        }
        set {
            userDefaults.set(newValue.rawValue, forKey: "sound")
        }
    }
    var enabled: Bool {
        get {
            let enabled = userDefaults.bool(forKey: "enabled")
            return enabled
        }
        set {
            userDefaults.set(newValue, forKey: "enabled")
        }
    }
    static var shared: SoundState = SoundState()
}

@objc class KettleCornService: NSObject, KettleCornServiceProtocol {
//    func hello(_ text: String, withReply reply: @escaping (String) -> Void) {
//        reply("Hello, \(text)!")
//    }
    
    var connection: NSXPCConnection!
    var service: PoppingServiceProtocol!
    
    override init() {
        super.init()
        connection = NSXPCConnection(machServiceName: "sh.linus.keypopper.PoppingService.mach")
        connection.remoteObjectInterface = NSXPCInterface(with: PoppingServiceProtocol.self)
        connection.resume()
        
        service = connection.remoteObjectProxyWithErrorHandler { error in
            fatalError("Error: \(error.localizedDescription)")
        } as! PoppingServiceProtocol
    }
    
    func changeSoundTo(_ soundInt: Int) {
        let sound = PoppingSounds(rawValue: soundInt)!
        // Store sound
        NSLog("Change sound")
        SoundState.shared.sound = sound
    }
    
    func changeSoundState(shouldPlaySound: Bool) {
        NSLog("Change state")
        SoundState.shared.enabled = shouldPlaySound
    }
    
    func boop() {
        guard SoundState.shared.enabled else { return }
        
        switch SoundState.shared.sound {
        case .pop:
            service.pop()
            NSLog("POP")
        case .frog:
            service.frog()
            NSLog("Frog")
        case .moo:
            service.moo()
            NSLog("Moo")
        }
    }
}
