//
//  Helper.swift
//
//
//  Created by BoiseITGuru on 11/25/23.
//

import SwiftUI

// MARK: Simple Way to Find if the app is in Split View
func isSplit() -> Bool {
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return false }

    return screen.windows.first?.frame.size != screen.screen.bounds.size
}
