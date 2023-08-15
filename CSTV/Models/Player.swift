//
//  Player.swift
//  CSTV
//
//  Created by Juliana Prado on 13/08/23.
//

import Foundation

// MARK: - Player Struct
struct Player: Codable {
    var firstName: String?
    var lastName: String?
    var imageURL: String?
    var nick: String?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case imageURL = "image_url"
        case nick = "name"
    }
    
    // MARK: - Getters
    func getFirstName() -> String {
        return self.firstName ?? ""
    }
    
    func getLastName() -> String {
        return self.lastName ?? ""
    }
    
    func getImageURL() -> String {
        return self.imageURL ?? ""
    }
    
    func getNick() -> String {
        return self.nick ?? ""
    }
    
}
