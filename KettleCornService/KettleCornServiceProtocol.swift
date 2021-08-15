//
//  KettleCornServiceProtocol.swift
//  KettleCornService
//
//  Created by Linus Skucas on 8/3/21.
//

import Foundation

@objc(KettleCornServiceProtocol) protocol KettleCornServiceProtocol {
//    func hello(_ text: String, withReply reply: @escaping (String) -> Void)
    func changeSoundTo(_ soundInt: Int)
    func changeSoundState(shouldPlaySound: Bool)
    func boop()
}

