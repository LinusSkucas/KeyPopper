//
//  AppDelegate.swift
//  KeyPopper Catcher
//
//  Created by Linus Skucas on 8/13/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
//    var connection: NSXPCConnection!
//    var service: KettleCornServiceProtocol!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
//        connection = NSXPCConnection(machServiceName: "sh.linus.keypopper.KettleCornService.mach")
//        connection.remoteObjectInterface = NSXPCInterface(with: KettleCornServiceProtocol.self)
//        connection.resume()
//
//        service = connection.remoteObjectProxyWithErrorHandler { error in
//            fatalError("Error: \(error.localizedDescription)")
//        } as! KettleCornServiceProtocol
        
        let eventMask = (1 << CGEventType.keyDown.rawValue) | (1 << CGEventType.keyUp.rawValue)
        NSLog("gggp")
        func cgEventCallback(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
            let connection = NSXPCConnection(machServiceName: "sh.linus.keypopper.KettleCornService.mach")
            connection.remoteObjectInterface = NSXPCInterface(with: KettleCornServiceProtocol.self)
            connection.resume()
            
            let service = connection.remoteObjectProxyWithErrorHandler { error in
                fatalError("Error: \(error.localizedDescription)")
            } as! KettleCornServiceProtocol
            service.boop()
            return nil
        }

        guard let eventTap = CGEvent.tapCreate(tap: .cgAnnotatedSessionEventTap, place: .headInsertEventTap, options: .listenOnly, eventsOfInterest: CGEventMask(eventMask), callback: cgEventCallback, userInfo: nil) else {
            DispatchQueue.main.async {
                NSLog("faileddddddddd")
            }
            return
        }
        let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
        CGEvent.tapEnable(tap: eventTap, enable: true)
        CFRunLoopRun()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
//        connection.invalidate()
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
