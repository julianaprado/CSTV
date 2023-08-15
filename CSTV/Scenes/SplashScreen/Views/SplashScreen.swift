//
//  SplashScreen.swift
//  CSTV
//
//  Created by Juliana Prado on 08/08/23.
//

import SwiftUI

struct SplashScreen: View {

    @StateObject private var viewModel = SplashScreenViewModel()

    var body: some View {
        NavigationView {
            NavigationLink(isActive: $viewModel.pushNewView) {
                MatchesScreen()
            } label: {
                ZStack(alignment: .center) {
                    Color.fuzePurple.ignoresSafeArea()
                    LogoView()
                }
            }
        }.navigationBarHidden(true)
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
                  tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor.blue
                  UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            viewModel.pushToNewView()
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
        
    static var previews: some View {
        SplashScreen()
    }
}
