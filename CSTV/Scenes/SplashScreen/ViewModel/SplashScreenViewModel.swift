//
//  SplashScreenViewModel.swift
//  CSTV
//
//  Created by Juliana Prado on 08/08/23.
//

import Foundation
import SwiftUI

/// Splash Screen View Model
final class SplashScreenViewModel: ObservableObject {
   
    @Published var pushNewView: Bool = false
    
    func pushToNewView() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.pushNewView = true
        }
    }
    
}
