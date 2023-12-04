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
import Combine
import Observation

@Observable
public class FlowManager {
    public var isAuthenticated = false
    public var themeConfig = ThemeConfig()
    public var pendingTxStatus = Flow.Transaction.Status.unknown
    public var pendingTx: String?
    public var txError: String?
    
    private var cancellable: AnyCancellable?
    
    public init() {
        cancellable = fcl.$currentUser.sink(receiveValue: { user in
            self.isAuthenticated = ( user != nil )
        })
    }
    
    public func mutate(cadence: String, args: [Flow.Cadence.FValue] = [], gasLimit: Int = 1000, proposer: FCLSigner? = nil, authorizors: [FCLSigner]? = nil, payers: [FCLSigner]? = nil) async {
        do {
            let tx = try await fcl.mutate(cadence: cadence, args: args, gasLimit: gasLimit, proposer: proposer, authorizors: authorizors, payers: payers)
            
            subscribeTransaction(txId: tx)
        } catch {
            txError = error.localizedDescription
        }
    }
    
    public func subscribeTransaction(txId: Flow.ID) {
        Task {
            do {
                pendingTx = txId.hex
                
                if fcl.currentEnv == .emulator {
                    sleep(UInt32(1))
                }
                
                let tx = try await txId.onceSealed()
                pendingTxStatus = .sealed
                
                await UIImpactFeedbackGenerator(style: .light).impactOccurred()
                
                await MainActor.run {
                    pendingTx = nil
                    
                    if (tx.errorMessage != "") {
                        txError = tx.errorMessage
                    }
                }
            } catch {
                await MainActor.run {
                    txError = error.localizedDescription
                }
            }
        }
    }

    public func subscribeTransaction(txId: String) {
        let id = Flow.ID(hex: txId)
        self.subscribeTransaction(txId: id)
    }
}
