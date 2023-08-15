//
//  Matches.swift
//  CSTV
//
//  Created by Juliana Prado on 08/08/23.
//

import Foundation

// MARK: - Matches Struct
struct Matches: Codable {
    var beginsAt: String?
    var status: String?
    var league: League?
    var opponents: [Opponents]?
    var serie: Serie?
    var isLive: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case beginsAt = "begin_at"
        case status
        case league
        case opponents
        case serie
        case isLive
    }

    // MARK: - Getters
    func getTime() -> String {
        return self.beginsAt ?? ""
    }
    
    func getStatus() -> String {
        return self.status ?? ""
    }
    
    func getLeagueName() -> String {
        return self.league?.name ?? ""
    }
    
    func getLeagueImageURL() -> String {
        return self.league?.imageURL ??  ""
    }
    
    func getOpponents() -> [Opponents] {
        return self.opponents ?? []
    }
    
    func getHowManyOpponents() -> HowManyOpponents {
        let count = opponents?.count
        switch count {
        case 0:
            return .none
        case 1:
            return .one
        case 2:
            return .two
        default:
            return .none
        }
    }
    
    func getOpponentName(whichTeam: OpponentEnum) -> String {
        let count = getHowManyOpponents()
        
        switch whichTeam {
        case .first:
            if count == HowManyOpponents.none {
                return StringConstants.toBeDecided
            } else {
                return self.opponents?[0].opponent?.name ?? ""
            }
        case .second:
            if count == HowManyOpponents.two {
                return opponents?[1].opponent?.name ?? ""
            } else {
                return StringConstants.toBeDecided
            }
        }
    }
    
    func getOpponentImageURL(whichTeam: OpponentEnum) -> String {
        let count = getHowManyOpponents()
        if count == HowManyOpponents.none {
            return ""
        }
        switch whichTeam {
        case .first:
            return self.opponents?[0].opponent?.imageUrl ?? ""
        case .second:
            if count == HowManyOpponents.two {
                return opponents?[1].opponent?.imageUrl ?? ""
            } else {
                return ""
            }
        }
    }
    
    func getSerieName() -> String {
        return self.serie?.name ?? ""
    }
    
    // MARK: - Setters
    
    mutating func setIsLiveBool(with value: Bool) {
        self.isLive = value
    }
}
