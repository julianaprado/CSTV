//
//  Team.swift
//  CSTV
//
//  Created by Juliana Prado on 13/08/23.
//

import Foundation

// MARK: - Team Struct
struct Team: Codable {
    var players: [Player]?
    
    private enum CodingKeys: String, CodingKey {
        case players
    }

}
