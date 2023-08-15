//
//  Opponent.swift
//  CSTV
//
//  Created by Juliana Prado on 08/08/23.
//

import Foundation

// MARK: - Opponents Struct
struct Opponents: Codable {
    var opponent: Opponent?
    
    private enum CodingKeys: String, CodingKey {
        case opponent
    }
    
    // MARK: - Getters
    func getTeamId() -> Int {
        return self.opponent?.id ?? 0
    }
    
    func getTeamURL() -> String {
        return self.opponent?.imageUrl ?? ""
    }
    
    func getTeamName() -> String {
        return self.opponent?.name ?? ""
    }
}

// MARK: - Opponent Struct
struct Opponent: Codable {
   
    var imageUrl: String?
    var name: String?
    var id: Int?
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case name
        case id
    }
}
