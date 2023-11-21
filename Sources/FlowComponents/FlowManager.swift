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

public let flowManager = FlowManager.shared

public struct ThemeConfig {
    public var primaryColor: Color
    public var secondaryColor: Color
    public var tertiaryColory: Color
    
    public init(primaryColor: Color, secondaryColor: Color, tertiaryColory: Color) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.tertiaryColory = tertiaryColory
    }
}

public class FlowManager: ObservableObject {
    public static let shared = FlowManager()
    public var themeConfig = ThemeConfig(primaryColor: Color.green, secondaryColor: Color.purple, tertiaryColory: Color.pink)
    
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
