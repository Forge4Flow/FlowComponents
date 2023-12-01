//
//  SwiftUIView.swift
//  Flow Components
//
//  Created by BoiseITGuru on 11/29/23.
//

import SwiftUI
import SyntaxHighlight

public struct ErrorView: View {
    @State private var error: String
    @State private var highlighter: Highlighter?
    
    public init(error: String) {
        self.error = error
    }
    
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
                Text(error)
            }
        }
    }
    
    private func loadHighlighter() {
        Task {
            do {
                let downloadedTheme = try await Theme(contentsOf: Themes.solarizedDark.url)
                let downloadedGrammar = try await Grammar(url: GrammarTypes.cadence.url)

                self.highlighter = Highlighter(string: error, theme: downloadedTheme, grammar: downloadedGrammar)
            } catch {
                // Handle errors
                print("Error loading syntax highlighter: \(error)")
            }
        }
    }

}
