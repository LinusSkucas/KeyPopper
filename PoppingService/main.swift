//
//  main.swift
//  PoppingService
//
//  Created by Linus Skucas on 8/14/21.
//

import Foundation

let delegate = PoppingServiceDelegate()
let listener = NSXPCListener(machServiceName: "sh.linus.keypopper.PoppingService.mach")
listener.delegate = delegate
listener.resume()
RunLoop.main.run()
