//
//  LogoView.swift
//  CSTV
//
//  Created by Juliana Prado on 08/08/23.
//

import Foundation
import SwiftUI

struct LogoView: View {
    @State private var isPulsing = true
    
    var body: some View {
        Image("CSGOLogo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: isPulsing ? 100 : 90, height: isPulsing ? 100 : 90)
            .scaleEffect(isPulsing ? 1.3 : 1)
            .animation(
                Animation.easeInOut(duration: 1)
                    .repeatForever(autoreverses: true)
            )
            .onAppear {
                isPulsing.toggle()
            }
    }
}
