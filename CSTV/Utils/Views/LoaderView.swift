//
//  LoaderView.swift
//  CSTV
//
//  Created by Juliana Prado on 11/08/23.
//

import Foundation
import SwiftUI

// Custom loader view in center of screen
struct LoaderView: ViewModifier {
    
    @Binding var shouldShow: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            
            Color.fuzePurple.ignoresSafeArea()
            if shouldShow {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            }
            content
                .opacity(shouldShow ? 0 : 1)
        }
    }
}

extension View {
    func loading(_ shouldShow: Binding<Bool>) -> some View {
        self.modifier(LoaderView(shouldShow: shouldShow))
    }
}
