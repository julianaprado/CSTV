//
//  Serie.swift
//  CSTV
//
//  Created by Juliana Prado on 08/08/23.
//

import Foundation

// MARK: - Serie Struct
struct Serie: Codable {
    let name: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "full_name"
    }
}
