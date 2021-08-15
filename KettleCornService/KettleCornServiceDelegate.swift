//
//  KettleCornServiceDelegate.swift
//  KettleCornService
//
//  Created by Linus Skucas on 8/3/21.
//

import Foundation

class KettleCornServiceDelegate: NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        let exportedObject = KettleCornService()
        newConnection.exportedInterface = NSXPCInterface(with: KettleCornServiceProtocol.self)
        newConnection.exportedObject = exportedObject
        
        newConnection.resume()
        return true
    }
}
