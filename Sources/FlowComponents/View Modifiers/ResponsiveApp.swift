//
//  ResponsiveView.swift
//
//
//  Created by BoiseITGuru on 11/24/23.
//

import FCL
import Combine
import SwiftUI

public struct ResponsiveApp: ViewModifier { 
    public func body(content: Content) -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let isLandscape = size.width > size.height
            #if os(macOS)
            let isiPad = false
            #else
            let isiPad = UIDevice.current.userInterfaceIdiom == .pad
            #endif
            let isMaxSplit = isSplit() && size.width < 400
            let properties = AppProperties(isLandscape: isLandscape, isiPad: isiPad, isSplit: isSplit(), isMaxSplit: isMaxSplit, size: size)
            
            content
                .frame(width: size.width, height: size.height)
                .environment(properties)
        }
    }
}

public extension View {
    func responsiveApp() -> some View {
        self.modifier(ResponsiveApp())
    }
}
