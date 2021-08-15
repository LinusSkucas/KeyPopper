//
//  PrefPane.swift
//  KeyPopper PrefPane
//
//  Created by Linus Skucas on 8/2/21.
//

import Foundation
import PreferencePanes
import SwiftUI
import AppKit

struct KettleCommunication {
    static let shared = KettleCommunication()
    var service: KettleCornServiceProtocol!

    init() {
        let connection = NSXPCConnection(machServiceName: "sh.linus.keypopper.KettleCornService.mach")
        connection.remoteObjectInterface = NSXPCInterface(with: KettleCornServiceProtocol.self)
        connection.resume()

        service = connection.remoteObjectProxyWithErrorHandler { error in
            fatalError("Error: \(error.localizedDescription)")
        } as! KettleCornServiceProtocol
    }
}

struct KeyPopperPrefPaneView: View {
    let communication = KettleCommunication.shared
    @AppStorage("enabled", store: UserDefaults.init(suiteName: "sh.linus.keypopper")!) var enabled: Bool = false
    @State var sound: PoppingSounds = .pop
    @AppStorage("sound", store: UserDefaults.init(suiteName: "sh.linus.keypopper")!) var soundInt: Int = 0
    
    var body: some View {
        Group {
            Group {
                Form {
                    Picker(selection: $sound, label:
                            VStack(alignment: .trailing, spacing: 2) {
                                Text("Sound")
                                Image(nsImage: NSImage(named: NSImage.Name("NXHelpIndex"))!)
                    }, content: {
                        Text("Popping")
                            .tag(PoppingSounds.pop)
                        Text("Mooing")
                            .tag(PoppingSounds.moo)
                        Text("Frog Thingying")
                            .tag(PoppingSounds.frog)
                    })
                    .pickerStyle(.radioGroup)
                    .padding(.top)
                    .onChange(of: sound) { newValue in
                        soundInt = newValue.rawValue
                        communication.service.changeSoundTo(newValue.rawValue)
                    }
                    .onAppear {
                        sound = PoppingSounds(rawValue: soundInt)!
                    }

                    Toggle(isOn: $enabled) {
                        HStack {
                            Text("Enable Sounds")
                            Image(nsImage: NSImage(named: NSImage.Name("NXFollow"))!)
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                        }
                    }
                    .toggleStyle(.switch)
                    .onChange(of: enabled) { newValue in
                        communication.service.changeSoundState(shouldPlaySound: newValue)
                    }
                }
            
                GroupBox {
                    HStack(alignment: .center) {
                        Image(nsImage: NSImage(named: NSImage.Name("NSSecurity"))!)
                            .resizable()
                            .scaledToFit()
                        Text("KeyPopper does not record or send your keystrokes anywhere.")
                    }
                }
                .padding(.bottom)
            }
            .frame(width: 480)
        }
        .frame(width: 500, height: 200)
    }
}


class KeyPopperPrefPane: NSPreferencePane {
    override func mainViewDidLoad() {
        let keyView = KeyPopperPrefPaneView()
        self.mainView = NSHostingView(rootView: keyView)
    }
}
