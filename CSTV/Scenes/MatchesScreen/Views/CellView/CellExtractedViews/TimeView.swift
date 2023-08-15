//
//  TimeView.swift
//  CSTV
//
//  Created by Juliana Prado on 12/08/23.
//

import Foundation
import SwiftUI

struct TimeView: View {
    
    var time: String
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .trailing) {
                HStack(alignment: .center) {
                    Text(time)
                        .font(Font.roboto(.Bold, size: 10))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }.padding(8)
                    .background(color)
                    .cornerRadius(16, corners: [.bottomLeft])
                    .cornerRadius(0, corners: [.bottomRight])
                    
            }
            .frame(minWidth: geometry.size.width, alignment: .trailing)
            .cornerRadius(16, corners: [.topLeft])
            .background(Color.fuzeCardColor)
            .clipped()
            
        }
    }
}
