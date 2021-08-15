//
//  PoppingSounds.swift
//  KeyPopper
//
//  Created by Linus Skucas on 8/8/21.
//

import Foundation

@objc enum PoppingSounds: Int, Identifiable {
    var id: Int {
        return self.rawValue
    }
    case pop = 0
    case moo = 1
    case frog = 2
}
