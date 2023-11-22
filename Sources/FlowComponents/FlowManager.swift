//
//  FlowManager.swift
//  Flow Components
//
//  Created by BoiseITGuru on 11/17/23.
//

import FCL
import Flow
import SwiftUI
import UIKit
import SyntaxHighlight

public let flowManager = FlowManager.shared

public struct ThemeConfig {
    public var primaryColor: SwiftUI.Color
    public var secondaryColor: SwiftUI.Color
    public var tertiaryColory: SwiftUI.Color
    public var textMateTheme: Themes
    
    public init() {
        self.init(primaryColor: Color.green, secondaryColor: Color.purple, tertiaryColory: Color.pink)
    }
    
    public init(primaryColor: SwiftUI.Color, secondaryColor: SwiftUI.Color, tertiaryColory: SwiftUI.Color) {
        self.init(primaryColor: primaryColor, secondaryColor: secondaryColor, tertiaryColory: tertiaryColory, tmTheme: .solarizedDark)
    }
    
    public init(primaryColor: SwiftUI.Color, secondaryColor: SwiftUI.Color, tertiaryColory: SwiftUI.Color, tmTheme: Themes) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.tertiaryColory = tertiaryColory
        self.textMateTheme = tmTheme
    }
}

public class FlowManager: ObservableObject {
    public static let shared = FlowManager()
    public var themeConfig = ThemeConfig()
    
    @Published public var pendingTxStatus = Flow.Transaction.Status.unknown

    @Published public var pendingTx: String? = nil
    
    @Published public var txError: String? = nil
    
    public func subscribeTransaction(txId: Flow.ID) {
        Task {
            do {
                DispatchQueue.main.async {
                    self.pendingTx = txId.hex
                }
                let tx = try await txId.onceSealed()
                await UIImpactFeedbackGenerator(style: .light).impactOccurred()
                print(tx)
                DispatchQueue.main.async {
                    if (tx.errorMessage != "") {
                        self.txError = tx.errorMessage
                    }
                    
                    self.pendingTx = nil
                }
            } catch {
                DispatchQueue.main.async {
                    self.pendingTx = nil
                    self.txError = error.localizedDescription
                }
            }
        }
    }

    public func subscribeTransaction(txId: String) {
        let id = Flow.ID(hex: txId)
        self.subscribeTransaction(txId: id)
    }
}
