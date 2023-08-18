//
//  TeamVsTeamView.swift
//  CSTV
//
//  Created by Juliana Prado on 13/08/23.
//

import Foundation
import SwiftUI

// Both Teams: Image and Name View
/// View used by multiple Views
struct TeamVsTeamView: View {
    
    var teamOneImageURL: String
    var teamOneName: String
    var teamTwoImageURL: String
    var teamTwoName: String
    
    var body: some View {
        HStack(alignment: .center) {
            TeamNameAndImageView(imageURL: teamOneImageURL, teamName: teamOneName)
            Spacer(minLength: 20)
            Text(StringConstants.vs)
                .font(Font.roboto(.Regular, size: 14))
                .foregroundColor(.white.opacity(0.5))
            Spacer(minLength: 20)
            TeamNameAndImageView(imageURL: teamTwoImageURL, teamName: teamTwoName)
        }.padding(12)
        .frame(height: 119)
    }
}
