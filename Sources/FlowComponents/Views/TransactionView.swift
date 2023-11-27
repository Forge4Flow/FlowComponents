//
//  TransactionView.swift
//  Flow Components
//
//  Created by BoiseITGuru on 11/17/23.
//


import SwiftUI
import Flow

public struct TransactionView: View {
    @Environment(\.presentationMode)
    var presentationMode
    
    public init() {}
    
    public var body: some View {
        ProgressView()
            .progressViewStyle(LargeFlowTransactionView())
            .onReceive(flowManager.$pendingTx) { tx in
                if tx == nil {
                    presentationMode.wrappedValue.dismiss()
                }
            }
    }
}

struct LargeFlowTransactionView: ProgressViewStyle {
    @Environment(\.colorScheme) var colorScheme
    @State private var txStatusString: String = "Pending"
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 10) {
            Text("Flow")
                .font(.title2)
            
            Text("Transaction")
                .font(.largeTitle).bold()
                .padding(.top, -5)
                .padding(.bottom, 30)
            
            LargeFlowCircleView()
                .padding(.bottom, 30)
            
            Text(txStatusString)
                .font(.largeTitle)
            
            Text("The transaction is pending! Please do not close the app")
                .multilineTextAlignment(.center)
                .font(.callout)
        }
        .padding(30)
        .background(colorScheme == .dark ? Color.black : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .frame(width: 325)
        .shadow(color: flowManager.themeConfig.primaryColor.opacity(0.8), radius: 10)
        .onReceive(flowManager.$pendingTxStatus, perform: { value in
            switch value {
            case .unknown:
                txStatusString = "Submitted"
            case .pending:
                txStatusString = "Pending"
            case .executed:
                txStatusString = "Executed"
            case .sealed:
                txStatusString = "Sealed"
            case .expired:
                txStatusString = "Expired"
            case .finalized:
                txStatusString = "Finalized"
            }
        })
    }
}

struct LargeFlowCircleView: View {
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            Image("flow", bundle: .module)
                .resizable()
                .frame(width: 100, height: 100)
            
            Circle()
                .stroke(flowManager.themeConfig.primaryColor.opacity(0.15), lineWidth: 10)
                .frame(width: 105, height: 105)
            
            Circle()
                .stroke(flowManager.themeConfig.primaryColor.opacity(0.2), lineWidth: 14)
                .frame(width: 200, height: 200)

            Circle()
                .trim(from: 0.1, to: 0.2)
                .stroke(flowManager.themeConfig.primaryColor, lineWidth: 7)
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
                }
            
            Circle()
                .trim(from: 0.4, to: 0.5)
                .stroke(flowManager.themeConfig.primaryColor, lineWidth: 7)
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
                }
            
            Circle()
                .trim(from: 0.7, to: 0.8)
                .stroke(flowManager.themeConfig.primaryColor, lineWidth: 7)
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
                }
        }
    }
}


#Preview {
    TransactionView()
}
