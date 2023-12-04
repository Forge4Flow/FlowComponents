//
//  ThemeConfig.swift
//
//
//  Created by BoiseITGuru on 12/3/23.
//

import SwiftUI
import Observation
import SyntaxHighlight

@Observable
public class ThemeConfig {
    public var primaryColor: SwiftUI.Color
    public var secondaryColor: SwiftUI.Color
    public var tertiaryColory: SwiftUI.Color
    public var textMateTheme: Themes
    
    public convenience init() {
        self.init(primaryColor: Color.green, secondaryColor: Color.purple, tertiaryColory: Color.pink)
    }
    
    public convenience init(primaryColor: SwiftUI.Color, secondaryColor: SwiftUI.Color, tertiaryColory: SwiftUI.Color) {
        self.init(primaryColor: primaryColor, secondaryColor: secondaryColor, tertiaryColory: tertiaryColory, tmTheme: .solarizedDark)
    }
    
    public init(primaryColor: SwiftUI.Color, secondaryColor: SwiftUI.Color, tertiaryColory: SwiftUI.Color, tmTheme: Themes) {
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
        self.tertiaryColory = tertiaryColory
        self.textMateTheme = tmTheme
    }
}
