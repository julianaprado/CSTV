//
//  HideView.swift
//  CSTV
//
//  Created by Juliana Prado on 14/08/23.
//

import Foundation
import SwiftUI

// Custom function to substitute normal .isHidden() function that allows a conditional
extension View {
    @ViewBuilder func toggleIsHidden(_ isHidden: Binding<Bool>) -> some View {
        if isHidden.wrappedValue {
            self.hidden()
        } else {
            self
        }
    }
}
