//
//  SwiftUIView.swift
//  
//
//  Created by BoiseITGuru on 11/27/23.
//

import SwiftUI
import CachedAsyncImage

public struct IPFSImage: View {
    @State private var cid: String
    
    public init(cid: String) {
        self.cid = cid
    }
    
    public var body: some View {
        CachedAsyncImage(url: URL(string: "https://nftstorage.link/ipfs/\(cid)")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if phase.error != nil {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .foregroundStyle(flowManager.themeConfig.secondaryColor, flowManager.themeConfig.primaryColor)
                        .aspectRatio(contentMode: .fit)
                    
                    Text("IPFS Error")
                        .font(.title3)
                }
                    .padding()
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
    }
}
