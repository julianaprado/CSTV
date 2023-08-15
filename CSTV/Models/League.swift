//
//  League.swift
//  CSTV
//
//  Created by Juliana Prado on 08/08/23.
//

import Foundation

struct League: Codable {
    
    var name: String?
    var imageURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
    }
}
