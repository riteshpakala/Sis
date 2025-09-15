//
//  Config.swift
//  Nea
//
//  Created by Ritesh Pakala Rao on 5/~/23.
//

import Granite
import SwiftUI

struct Config: GraniteComponent {
    @Command var center: Center
    
    @Relay var config: ConfigService
    
    @SharedObject(WindowVisibilityManager.id) var windowVisibility: WindowVisibilityManager
    @SharedObject(SessionManager.id) var session: SessionManager
}
