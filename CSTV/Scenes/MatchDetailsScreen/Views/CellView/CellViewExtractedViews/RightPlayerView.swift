//
//  RightPlayerView.swift
//  CSTV
//
//  Created by Juliana Prado on 13/08/23.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct RightPlayerView: View {
    
    var nickName: String
    var name: String
    var imageURL: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 1)
                .fill(Color.fuzeCardColor)
                .frame(height: 54)
                .cornerRadius(16, corners: [.topLeft, .bottomLeft])
            HStack(spacing: 12) {
                PlayerImage(imageURL: imageURL)
                PlayerNameAndNickView(nickName: nickName,
                                      name: name)
            }
        }
    }
    
}
