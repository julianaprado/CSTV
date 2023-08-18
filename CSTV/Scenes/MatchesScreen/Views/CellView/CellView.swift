//
//  CellView.swift
//  CSTV
//
//  Created by Juliana Prado on 12/08/23.
//

import Foundation
import SwiftUI

struct CellView: View {
    
    var time: String
    var teamOneName: String
    var teamOneImageURL: String
    var teamTwoName: String
    var teamTwoImageURL: String
    var league: String
    var serie: String
    var leagueImageURL: String
    var isLive: Bool
    
    var body: some View {
        ZStack {
            VStack {
                TimeView(time: time, color: isLive ? Color.fuzeRed : Color.fuzeGray)
                    .frame(height: 26)
                TeamVsTeamView(teamOneImageURL: teamOneImageURL,
                               teamOneName: teamOneName,
                               teamTwoImageURL: teamTwoImageURL,
                               teamTwoName: teamTwoName)
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.2))
                LeagueAndSeriesView(imageURL: leagueImageURL, league: league, series: serie)
            }
        }
            .background(Color.fuzeCardColor)
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
    }
}
