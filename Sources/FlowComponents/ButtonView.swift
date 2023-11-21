//
//  ButtonView.swift
//  Flow Components
//
//  Created by BoiseITGuru on 11/15/23.
//

import SwiftUI

public struct LargeButton: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(flowManager.themeConfig.primaryColor)
            .cornerRadius(15)
            .buttonStyle(PlainButtonStyle())
    }
}

public extension Button {
    func largeButton() -> some View {
        self.modifier(LargeButton())
    }
}

public struct ButtonView: View {
    private var labelContent: LabelContent
    private var action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
        self.labelContent = .text(title)
        self.action = action
    }

    public init<V: View>(@ViewBuilder label: @escaping () -> V, action: @escaping () -> Void) {
        self.labelContent = .view(AnyView(label()))
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            switch labelContent {
            case .text(let title):
                Text(title)
                    .font(.title2)
                    .foregroundStyle(Color.black)
            case .view(let view):
                view
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .background(flowManager.themeConfig.primaryColor)
        .cornerRadius(15)
        .buttonStyle(PlainButtonStyle())
        
    }

    private enum LabelContent {
        case text(String)
        case view(AnyView)
    }
}


