//
//  FlowApp.swift
//
//
//  Created by BoiseITGuru on 12/3/23.
//

import SwiftUI

public struct FlowApp<Content: View>: View {
    @State public var flowManager = FlowManager()
    private var mainView: ()-> Content

    public init(@ViewBuilder mainView: @escaping ()->Content) {
        self.mainView = mainView
    }
    
    public var body: some View {
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

            ZStack {
                mainView()
                    .frame(width: size.width, height: size.height)
                    .sheet(isPresented: .constant(flowManager.txError != nil), onDismiss: { flowManager.txError = nil }, content: {
                        ErrorView()
                    })
        
                if flowManager.pendingTx != nil {
                    TransactionView()
                }
            }
            .environment(properties)
            .environment(flowManager)
        }
    }
    
    // MARK: Simple Way to Find if the app is in Split View
    private func isSplit() -> Bool {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return false }

        return screen.windows.first?.frame.size != screen.screen.bounds.size
    }
}
