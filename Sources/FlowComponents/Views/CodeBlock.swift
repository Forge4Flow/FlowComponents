//
//  CodeBlock.swift
//  Flow Components
//
//  Created by BoiseITGuru on 11/20/23.
//

import SwiftUI
import SyntaxHighlight

public struct CodeBlock: View {
    @Environment(FlowManager.self) private var flowManager
    
    @State private var title: String
    @State private var code: String
    @State private var grammar: GrammarTypes
    @State private var theme: Themes?
    
    public init(cadenceCode: CadenceCode) {
        self.init(title: cadenceCode.fileName, code: cadenceCode.code, grammar: .cadence)
    }
    
    public init(code: String, grammar: GrammarTypes) {
        self.init(title: grammar.name, code: code, grammer: grammar, theme: nil)
    }
    
    public init(code: String, grammar: GrammarTypes, theme: Themes) {
        self.init(title: grammar.name, code: code, grammer: grammar, theme: theme)
    }
    
    public init(title: String, code: String, grammar: GrammarTypes) {
        self.init(title: title, code: code, grammer: grammar, theme: nil)
    }
    
    public init(title: String, code: String, grammer: GrammarTypes, theme: Themes?) {
        self.title = title
        self.code = code
        self.grammar = grammer
        self.theme = theme
    }
    
    public var body: some View {
        GroupBox {
            SyntaxText(code: code, theme: (theme != nil) ? theme! : flowManager.themeConfig.textMateTheme, grammar: grammar)
        } label: {
            Text(title)
        }

    }
}

public extension CodeBlock {
    func tmTheme(_ theme: Themes) -> some View {
        self.theme = theme
        
        return self
    }
}
