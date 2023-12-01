//
//  ErrorWrapper.swift
//  
//
//  Created by BoiseITGuru on 11/30/23.
//

import SwiftUI

struct ErrorWrapper: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showError = true
    @State var error: String
    
    var body: some View {
        EmptyView()
            .sheet(isPresented: $showError) {
                presentationMode.wrappedValue.dismiss()
            } content: {
                ErrorView(error: error)
            }

    }
}
