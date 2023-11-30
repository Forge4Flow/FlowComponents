//
//  SwiftUIView.swift
//  Flow Components
//
//  Created by BoiseITGuru on 11/29/23.
//

import SwiftUI
import ecDAO
import FlowComponents

struct ErrorView: View {
    @State var error: String
    
    var body: some View {
        VStack {
            Text("Transaction Error")
                .font(.title)
                .padding(.vertical, 10)
            
            CodeBlock(code: error, grammar: .cadence)
                .padding(.horizontal, 15)
        }
    }
}
