//
//  ResponsiveView.swift
//
//
//  Created by BoiseITGuru on 11/25/23.
//

import SwiftUI

public struct ResponsiveView<Content: View>: View {
    private var sidebarView: Content
    private var mainView: Content
    
    public init(sidebar: Content, main: Content) {
        sidebarView = sidebar
        mainView = main
    }
    
    public var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let isLandscape = size.width > size.height
            let isiPad = UIDevice.current.userInterfaceIdiom == .pad
            let isMaxSplit = isSplit() && size.width < 400
            let properties = AppProperties(isLandscape: isLandscape, isiPad: isiPad, isSplit: isSplit(), isMaxSplit: isMaxSplit, size: size)
            
            Group {
                VStack {
                    mainView
                        .onReceive(properties.$isLandscape) { value in
                            print(value)
                        }
                }
            }
                .frame(width: size.width, height: size.height)
                .environment(properties)
        }
    }
}
