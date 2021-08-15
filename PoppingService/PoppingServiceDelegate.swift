//
//  PoppingServiceDelegate.swift
//  PoppingService
//
//  Created by Linus Skucas on 8/14/21.
//

import Foundation

class PoppingServiceDelegate: NSObject, NSXPCListenerDelegate {
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        let exportedObject = PoppingService()
        newConnection.exportedInterface = NSXPCInterface(with: PoppingServiceProtocol.self)
        newConnection.exportedObject = exportedObject
        
        newConnection.resume()
        return true
    }
}
