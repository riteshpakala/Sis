import Granite
import SwiftUI
import VaultKit

extension EnvironmentService {
    struct Boot: GraniteReducer {
        typealias Center = EnvironmentService.Center
        
        @Relay var config: ConfigService
        
        @Event var showPopup: ShowPopup.Reducer
        @Event var closePopup: ClosePopup.Reducer
        
        @Event var hotkeyDetected: HotkeyDetected.Reducer
        @Event var promptStudioHotkeyDetected: PromptStudioHotkeyDetected.Reducer
        
        func reduce(state: inout Center.State) {
            
            //Windows
            state.pane = .init(id: InteractionManager.Kind.mount.rawValue,
                               defaultSize: WindowComponent.Style.defaultWindowSize,
                               useMain: true) {
                PaneView()
            }
            
            state.pane?.build()
            
            state.promptStudioPane = .init(id: InteractionManager.Kind.promptStudio.rawValue,
                                           defaultSize: WindowComponent.Kind.promptStudio.defaultSize) {
                PromptStudioPaneView()
            }
            
            state.promptStudioPane?.build(title: "Prompt Studio", center: true)
            
            //Interactions Hotkeys
            InteractionManager.shared.setPopupObserver(showPopup, closeReducer: closePopup)
            
            InteractionManager.shared.setHotkeyObserver(hotkeyDetected)
            InteractionManager.shared.setPromptStudioHotkeyObserver(promptStudioHotkeyDetected)
            InteractionManager.shared.registerHotkey(config.state.mountHotkey)
            InteractionManager.shared.registerHotkey(config.state.promptStudioHotkey, kind: .promptStudio)
            
            
            //Config
            config.center.$state.binding.isAccountTabActive.wrappedValue = true
        }
    }
}


