import Granite
import SwiftUI
import LaunchAtLogin
import SandKit
// import MarqueKit

extension ConfigService {
    struct Center: GraniteCenter {
        struct State: GraniteState {
            var showVisualGuide: Bool = false
            
            //Launch
            var launchAtLogin: Bool = false {
                didSet {
                    LaunchAtLogin.isEnabled = launchAtLogin
                }
            }
            
            var streamResponse: Bool = true
            
            //Hotkeys
            var mountHotkey: InteractionManager.HotkeyOptions = .n
            var promptStudioHotkey: InteractionManager.HotkeyOptions = .p
            
            //Prompt Config
            var customPromptConfigEnabled: Bool = false
            var customPromptConfig: PromptConfig = .init()
            
            //API Key
            var customAPIKey: String? = nil
            
            var isCustomAPIKeySet: Bool {
                (
                    customAPIKey != nil && SessionManager.IS_API_ACCESS_ENABLED
                )
            }
            
            //History
            var storeHistory: Bool = true
            var history: [QueryHistory] = []
            
            //Remote
            var isSettingsActive: Bool = false {
                didSet {
                    if isSettingsActive {
                        isDataPrivacyTabActive = false
                        isAccountTabActive = false
                    }
                }
            }
            var isDataPrivacyTabActive: Bool = false {
                didSet {
                    if isDataPrivacyTabActive {
                        isAccountTabActive = false
                        isSettingsActive = false
                    }
                }
            }
            var isAccountTabActive: Bool = true {
                didSet {
                    if isAccountTabActive {
                        isDataPrivacyTabActive = false
                        isSettingsActive = false
                    }
                }
            }
        }
        
        @Event var updateHotkey: Hotkey.Reducer
        @Event var setAPIKey: SetCustomAPIKey.Reducer
        @Event var removeAPIKey: RemoveCustomAPIKey.Reducer
        @Event var updateHistory: UpdateHistory.Reducer
        
        @Store(persist: "nea.persistence.config.0003", autoSave: true, preload: true) public var state: State
    }
    
   /* static func decode(_ bytes: [UInt32]) -> String? {
        let result = MarqueKit().decodeBytes(bytes)
        
//        guard let payload = result.payload.components(separatedBy: MarqueKit.symbol).first else {
//            print("{TEST} failed to seperate")
//            return nil
//        }
        
        var payload = result.payload.replacingOccurrences(of: "<m12>", with: "")
        payload = payload.replacingOccurrences(of: "</m12>", with: "")
        
        if let decodedData = Data(base64Encoded: payload),
           let decodedString = String(data: decodedData, encoding: .utf8) {
            return decodedString
        } else {
            return nil
        }
        return nil
    } */
}

fileprivate extension Character {
    func utf8() -> UInt8 {
        let utf8 = String(self).utf8
        return utf8[utf8.startIndex]
    }
}
