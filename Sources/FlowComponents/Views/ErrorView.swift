//
//  SwiftUIView.swift
//  Flow Components
//
//  Created by BoiseITGuru on 11/29/23.
//

import SwiftUI
import SyntaxHighlight

public struct ErrorView: View {
    @Environment(FlowManager.self) private var flowManager
    @State private var highlighter: Highlighter?
    
    public init() {}
    
    public var body: some View {
        VStack {
            Text("Flow Error")
                .font(.title)
                .padding(.vertical, 10)
            
            GroupBox {
                ScrollView {
                    errorText
                }
            } label: {
                Text("Cadence")
            }
        }
        .onAppear {
            loadHighlighter()
        }
    }
    
    var errorText: some View {
        Group {
            if let highlighter = highlighter {
                Text(from: highlighter)
                    .padding(1)
                    .background(highlighter.theme.backgroundColor.opacity(0.8))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            } else {
                Text(flowManager.txError ?? "Problem Loading Error Text")
            }
        }
    }
    
    private func loadHighlighter() {
        Task {
            do {
                let downloadedTheme = try await Theme(contentsOf: Themes.solarizedDark.url)
                let downloadedGrammar = try await Grammar(url: GrammarTypes.cadence.url)

                self.highlighter = Highlighter(string: flowManager.txError ?? "Problem Loading Error Text", theme: downloadedTheme, grammar: downloadedGrammar)
            } catch {
                // Handle errors
                print("Error loading syntax highlighter: \(error)")
            }
        }
    }

}
