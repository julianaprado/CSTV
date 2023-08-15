//
//  MatchDetailsCell.swift
//  CSTV
//
//  Created by Juliana Prado on 13/08/23.
//

import Foundation
import SwiftUI

struct MatchDetailsCell: View {
    
    var nickNameTeamOne: String
    var nameTeamOne: String
    var imageURLTeamOne: String
    var nickNameTeamTwo: String
    var nameTeamTwo: String
    var imageURLTeamTwo: String
    
    var body: some View {
        ZStack {
            HStack {
                LeftPlayerView(nickName: nickNameTeamOne,
                               name: nameTeamOne,
                               imageURL: imageURLTeamOne)
                Spacer(minLength: 13)
                RightPlayerView(nickName: nickNameTeamTwo,
                                name: nameTeamTwo,
                                imageURL: imageURLTeamTwo)
            }
        }
    }
    
}
