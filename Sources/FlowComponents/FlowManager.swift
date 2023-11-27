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
                let tx = try await txId.onceSealed()
                await UIImpactFeedbackGenerator(style: .light).impactOccurred()
                print(tx)
                DispatchQueue.main.async {
                    flowManager.closeTransactionIfNeed {
                        if (tx.errorMessage != "") {
                            self.txError = tx.errorMessage
                        }
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    flowManager.closeTransactionIfNeed {
                        self.txError = error.localizedDescription
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            let discoveryVC = UIHostingController(rootView: TransactionView())
            discoveryVC.view.backgroundColor = .clear
            discoveryVC.modalPresentationStyle = .overFullScreen
            UIApplication.shared.topMostViewController?.present(discoveryVC, animated: true)
        }
    }

    public func subscribeTransaction(txId: String) {
        let id = Flow.ID(hex: txId)
        self.subscribeTransaction(txId: id)
    }
    
    public func closeTransactionIfNeed(completion: (() -> Void)? = nil) {
        guard let vc = UIApplication.shared.topMostViewController as? UIHostingController<TransactionView> else {
            return
        }
        vc.dismiss(animated: true, completion: completion)
    }
}
