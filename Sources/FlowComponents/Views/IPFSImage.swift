//
//  SwiftUIView.swift
//  
//
//  Created by BoiseITGuru on 11/27/23.
//

import SwiftUI
import CachedAsyncImage

struct IPFSImage: View {
    @State var cid: String
    
    var body: some View {
        CachedAsyncImage(url: URL(string: "https://nftstorage.link/ipfs/\(cid)")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if phase.error != nil {
                Image(systemName: "exclamationmark.triangle.fill")
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
    }
}
