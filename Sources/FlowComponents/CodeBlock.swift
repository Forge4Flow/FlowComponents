//
//  CodeBlock.swift
//  Flow Components
//
//  Created by BoiseITGuru on 11/20/23.
//

import SwiftUI
import SyntaxHighlight

public struct CodeBlock: View {
    @State private var title: String
    @State private var code: String
    @State private var grammar: GrammarTypes
    @State private var theme: Themes
    
    public init(code: String, grammar: GrammarTypes) {
        self.init(title: grammar.name, code: code, grammer: grammar, theme: flowManager.themeConfig.textMateTheme)
    }
    
    public init(code: String, grammar: GrammarTypes, theme: Themes) {
        self.init(title: grammar.name, code: code, grammer: grammar, theme: theme)
    }
    
    public init(title: String, code: String, grammar: GrammarTypes) {
        self.init(title: title, code: code, grammer: grammar, theme: flowManager.themeConfig.textMateTheme)
    }
    
    public init(title: String, code: String, grammer: GrammarTypes, theme: Themes) {
        self.title = title
        self.code = code
        self.grammar = grammer
        self.theme = theme
    }
    
    public var body: some View {
        GroupBox {
            SyntaxText(code: code, theme: theme, grammar: grammar)
        } label: {
            Text(title)
        }

    }
}
