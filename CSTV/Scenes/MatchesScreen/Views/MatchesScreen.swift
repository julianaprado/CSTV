//
//  MatchesScreen.swift
//  CSTV
//
//  Created by Juliana Prado on 11/08/23.
//

import Foundation
import SwiftUI
import Combine

struct MatchesScreen: View {
        
    @ObservedObject var viewModel = MatchesScreenViewModel()
    
    init() {
        UINavigationBar.appearance()
            .largeTitleTextAttributes = [
                .font: UIFont(name: "Roboto-Regular", size: 32)!,
                .foregroundColor: UIColor.white]
        UINavigationBar.setAnimationsEnabled(false)
       
    } 
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(0..<viewModel.allMatches.count, id: \.self) { index in
                    let timeAndLive = viewModel.formatDateString(viewModel.allMatches[index].getTime())
                    let live = timeAndLive.0
                    let time = timeAndLive.1
                    let league = viewModel.allMatches[index].getLeagueName()
                    let serie = viewModel.allMatches[index].getSerieName()
                    NavigationLink(destination:
                                    MatchDetailsView(manager: viewModel.networkManager,
                                                     navigationTitle: "\(league) + \(serie)",
                                                     teams: viewModel.allMatches[index].getOpponents(),
                                                     howMany: viewModel.allMatches[index].getHowManyOpponents(),
                                                     time: time)) {
                        CellView(time: time,
                                 teamOneName: viewModel.allMatches[index].getOpponentName(whichTeam: .first),
                                 teamOneImageURL: viewModel.allMatches[index].getOpponentImageURL(whichTeam: .first),
                                 teamTwoName: viewModel.allMatches[index].getOpponentName(whichTeam: .second),
                                 teamTwoImageURL: viewModel.allMatches[index].getOpponentImageURL(whichTeam: .second),
                                 league: league,
                                 serie: serie,
                                 leagueImageURL: viewModel.allMatches[index].getLeagueImageURL(),
                                 isLive: live)
                    } 
                }
                ProgressView()
                    .progressViewStyle(.circular)
                    .toggleIsHidden($viewModel.shouldStopPagination)
                    .onAppear {
                        self.viewModel.getMoreUpcomingMatches()
                    }
            }.padding(.top, 15)
                .padding(.leading, 24)
                .padding(.trailing, 24)
        }.refreshable {
            self.viewModel.addSubscriber()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle(StringConstants.matchesNavigationTitle)
        .navigationBarTitleDisplayMode(.large)
        .preferredColorScheme(.dark)
        .loading($viewModel.isLoading)
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
                  tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor.blue
                  UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UIRefreshControl.appearance().tintColor = UIColor.gray
            self.viewModel.addSubscriber()
        }
    }
}

struct MatchesScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        MatchesScreen()
    }
}
