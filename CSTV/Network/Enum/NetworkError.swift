//
//  NetworkError.swift
//  CSTV
//
//  Created by Juliana Prado on 08/08/23.
//

import Foundation

// NetworkError
/// Currently not treating for errors
/// TODO: Check for errors in the future
enum NetworkError: Error {
    case urlError
    case dataError
    case decodingError
    case noConnection
    case unknownError
    case noErrors
}
