//
//  main.swift
//  KettleCornService
//
//  Created by Linus Skucas on 8/3/21.
//

import Foundation

let delegate = KettleCornServiceDelegate()
let listener = NSXPCListener(machServiceName: "sh.linus.keypopper.KettleCornService.mach")
listener.delegate = delegate
listener.resume()
RunLoop.main.run()
