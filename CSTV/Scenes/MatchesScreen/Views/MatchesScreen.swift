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
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 24) {
                ForEach($viewModel.allMatches, id: \Matches.id) { $match in
                    let league = match.getLeagueName()
                    let serie = match.getSerieName()
                    NavigationLink(destination:
                                    MatchDetailsView(manager: viewModel.networkManager,
                                                     navigationTitle: "\(league) \(serie)",
                                                     teams: match.getOpponents(),
                                                     howMany: match.getHowManyOpponents(),
                                                     time: match.timeString ?? "")) {
                        CellView(time: match.timeString ?? "",
                                 teamOneName: match.getOpponentName(whichTeam: .first),
                                 teamOneImageURL: match.getOpponentImageURL(whichTeam: .first),
                                 teamTwoName: match.getOpponentName(whichTeam: .second),
                                 teamTwoImageURL: match.getOpponentImageURL(whichTeam: .second),
                                 league: league,
                                 serie: serie,
                                 leagueImageURL: match.getLeagueImageURL(),
                                 isLive: match.getIsLive())
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
extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
