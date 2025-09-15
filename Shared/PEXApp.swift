//
//  PEXApp.swift
//  Shared
//
//  Created by Ritesh Pakala Rao on 7/18/22.
//

import SwiftUI
import Combine
import Granite
import VaultKit

@main
struct PEXApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @Relay var environment: EnvironmentService
    
    let pubShowHideMount = NotificationCenter.default
        .publisher(for: NSNotification.Name("nyc.stoic.Nea.ShowHideMount"))
    
    let pubShowHidePromptStudio = NotificationCenter.default
        .publisher(for: NSNotification.Name("nyc.stoic.Nea.ShowHidePromptStudio"))
    
    let pubDidFinishLaunching = NotificationCenter.default
        .publisher(for: NSNotification.Name("nyc.stoic.Nea.DidFinishLaunching"))

    internal var cancellables = Set<AnyCancellable>()
    
    init() {
        pubShowHideMount.sink { _ in
            InteractionManager.shared.observeHotkey(kind: .mount)
        }.store(in: &cancellables)
        
        pubShowHidePromptStudio.sink { _ in
            InteractionManager.shared.observeHotkey(kind: .promptStudio)
        }.store(in: &cancellables)
        
        
        // TODO: Is this the best place?
        
        environment.center.boot.send()
        
        //TODO: DEV
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            InteractionManager.shared.observeHotkey(kind: .mount)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            Home()
                .onReceive(pubDidFinishLaunching) { _ in
                    //TODO: DEV
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        InteractionManager.shared.observeHotkey(kind: .mount)
                    }
                }
                .onChange(of: VaultManager.isSubscribed) { newState in
                    print("[MAIN] isSubscribed \(newState)")
                }
        }
    }
}

extension TimeZone {
    var formattedName: String {
        let start = localizedName(for: .generic, locale: .current) ?? "Unknow"
        return "\(start) - \(identifier)"
    }
}
