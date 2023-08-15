//
//  TeamNameAndImageView.swift
//  CSTV
//
//  Created by Juliana Prado on 12/08/23.
//

import Foundation
import SwiftUI
import CachedAsyncImage

// Team Image and Team Name View
/// View used by multiple Views
struct TeamNameAndImageView: View {
    
    var imageURL: String
    var teamName: String
    
    var body: some View {
        GeometryReader { geometry in
            LazyVStack(alignment: .center, spacing: 10) {
                CachedAsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image.teamModifier()
                    case .failure:
                        Image(systemName: StringConstants.circle).iconModifier()
                    case .empty:
                        Image(systemName: StringConstants.circle).iconModifier()
                    @unknown default:
                        ProgressView()
                    }
                }
                Text(teamName)
                    .font(Font.roboto(.Regular, size: 16))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .frame(maxWidth: geometry.size.width)
            }.clipped()
        }
    }
}
