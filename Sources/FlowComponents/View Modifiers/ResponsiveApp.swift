//
//  ResponsiveView.swift
//
//
//  Created by BoiseITGuru on 11/24/23.
//

import SwiftUI

public class AppProperties: Observable, ObservableObject {
    @Published public var isLandscape: Bool
    @Published public var isiPad: Bool
    @Published public var isSplit: Bool
    @Published public var isMaxSplit: Bool
    @Published public var size: CGSize
    
    public init(isLandscape: Bool, isiPad: Bool, isSplit: Bool, isMaxSplit: Bool, size: CGSize) {
        self.isLandscape = isLandscape
        self.isiPad = isiPad
        self.isSplit = isSplit
        self.isMaxSplit = isMaxSplit
        self.size = size
    }
}

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
