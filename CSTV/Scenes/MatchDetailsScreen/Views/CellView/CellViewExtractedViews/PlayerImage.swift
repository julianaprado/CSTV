//
//  PlayerImage.swift
//  CSTV
//
//  Created by Juliana Prado on 14/08/23.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct PlayerImage: View {
    
    var imageURL: String
    
    var body: some View {
        CachedAsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .success(let image):
                image.playerModifier()
            case .failure:
                Image(systemName: StringConstants.square).playerModifier()
            case .empty:
                Image(systemName: StringConstants.square).playerModifier()
            @unknown default:
                ProgressView()
            }
        }
        .padding(.bottom, 20)
        .padding(.leading, 5)
    }
}
