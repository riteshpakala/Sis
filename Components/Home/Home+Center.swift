//
//  Home+Center.swift
//  PEX
//
//  Created by Ritesh Pakala Rao on 7/18/22.
//  Copyright (c) 2022 Stoic Collective, LLC.. All rights reserved.
//

import Granite
import GraniteUI
import SwiftUI
import Combine

extension Home {
    struct Center: GraniteCenter {
        
        struct State: GraniteState {
            var currentTabIndex: Int = 0
            var isVisible: Bool = true
        }
        
        @Store public var state: Center.State
        
        //@Event(.onAppear) var didAppear: DidAppear.Reducer
    }
}

