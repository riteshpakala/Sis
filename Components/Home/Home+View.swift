//
//  Home+View.swift
//  Nea
//
//  Created by Ritesh Pakala Rao on 4/~/23.
//

import Granite
import GraniteUI
import SwiftUI
import Foundation

extension Home: View {
    public var view: some View {
        ZStack {
            Text("Sis")
                .font(Fonts.live(.title3, .bold))
        }
    }
}

struct EmptyComponent: GraniteComponent {
    struct Center: GraniteCenter {
        struct State: GraniteState {
            
        }
        @Store var state: State
    }
    
    @Command var center: Center
}

extension EmptyComponent: View {
    var view: some View {
        EmptyView()
    }
}


