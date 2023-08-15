//
//  MatchDetailsView.swift
//  CSTV
//
//  Created by Juliana Prado on 13/08/23.
//

import Foundation
import SwiftUI

struct MatchDetailsView: View {
    
    @ObservedObject var viewModel: MatchDetailsViewModel
    var navigationBarTitle: String
    
    init(manager: NetworkManager,
         navigationTitle: String,
         teams: [Opponents],
         howMany: HowManyOpponents,
         time: String) {
        self.navigationBarTitle = navigationTitle
        self.viewModel = MatchDetailsViewModel(manager: manager, teams: teams, howManyOpponents: howMany, time: time)
    }
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            LazyVStack {
                    TeamVsTeamView(teamOneImageURL: viewModel.getFirstOpponent()?.getTeamURL() ?? "",
                                   teamOneName: viewModel.getFirstOpponent()?.getTeamName() ?? StringConstants.toBeDecided,
                                   teamTwoImageURL: viewModel.getSecondOpponent()?.getTeamURL() ?? "",
                                   teamTwoName: viewModel.getSecondOpponent()?.getTeamName() ?? StringConstants.toBeDecided)
                    HStack {
                        Text(viewModel.time)
                            .font(Font.roboto(.Bold, size: 12))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    }.padding(20)
                ForEach(0..<5, id: \.self) { index in
                    let teamOne = viewModel.getPlayerStats(index: index, ofTeam: .first)
                    let teamTwo = viewModel.getPlayerStats(index: index, ofTeam: .second)
                    
                    MatchDetailsCell(nickNameTeamOne: teamOne[0],
                                     nameTeamOne: teamOne[1],
                                     imageURLTeamOne: teamOne[2],
                                     nickNameTeamTwo: teamTwo[0],
                                     nameTeamTwo: teamTwo[1],
                                     imageURLTeamTwo: teamTwo[2])
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: goBack) {
            HStack {
                Image(systemName: StringConstants.backArrow)
                    .tint(.white)
            }
        }
        )
        .navigationBarTitle(navigationBarTitle)
        .navigationBarTitleDisplayMode(.inline)
        .loading($viewModel.isLoading)
        .onAppear {
            self.viewModel.getTeams()
        }
    }
    
    func goBack() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
}
