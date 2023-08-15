//
//  PlayerNameAndNickView.swift
//  CSTV
//
//  Created by Juliana Prado on 14/08/23.
//

import Foundation
import SwiftUI

struct PlayerNameAndNickView: View {
    
    var nickName: String
    var name: String
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    Text(nickName)
                        .font(Font.roboto(.Bold, size: 14))
                        .multilineTextAlignment(.center)
                        .scaledToFit()
                                        .minimumScaleFactor(0.5)
                        .foregroundColor(.white)
                        .lineLimit(1)
                    Text(name)
                        .font(Font.roboto(.Regular, size: 12))
                        .multilineTextAlignment(.center)
                        .scaledToFit()
                                        .minimumScaleFactor(0.5)
                        .foregroundColor(.white)
                        .lineLimit(1)
                }.frame(minWidth: geometry.size.width, minHeight: geometry.size.height, alignment: .center)
                    .padding(3)
            }
        }
    }
}
