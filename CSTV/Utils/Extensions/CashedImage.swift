//
//  CashedImage.swift
//  CSTV
//
//  Created by Juliana Prado on 15/08/23.
//

import Foundation
import SwiftUI
import CachedAsyncImage

extension View {
    
    func cashedImage(url: String, modifier: [some View]) -> CachedAsyncImage<some View> {
        CachedAsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .success(let image):
                image.teamModifier()
            case .failure:
                Image(systemName: StringConstants.circle)
            case .empty:
                Image(systemName: StringConstants.circle)
            @unknown default:
                ProgressView()
            }
        }
    }
    
}
