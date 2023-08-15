//
//  NetworkManager.swift
//  CSTV
//
//  Created by Juliana Prado on 08/08/23.
//

import Combine
import Foundation
import SwiftUI
import Network

class NetworkManager {
    
    // MARK: - Header
    let headers = [
        "accept": "application/json",
        "authorization": "Bearer \(StringConstants.apiToken)"
    ]
    
    // MARK: - Public Fetchers
    func getTeams(withID teamId: String) -> AnyPublisher<[Team], Never>? {
        guard let teamURLRequest = getURLRequest(ofType: URLType.team, teamId: teamId) else {
            return nil
        }
        return fetch(teamURLRequest, defaultValue: [Team]()).eraseToAnyPublisher()
    }
    
    func getUpcomingMatches(page: Int) -> AnyPublisher<[Matches], Never>? {
        let pagination = String(page)
        guard let upcomingURLRequest = getURLRequest(ofType: URLType.upcoming, page: pagination) else {
            return nil
        }
        return fetch(upcomingURLRequest, defaultValue: [Matches]()).eraseToAnyPublisher()
    }
    
    func getRunningMatches() -> AnyPublisher<[Matches], Never>? {
        guard let runningURLRequest = getURLRequest(ofType: URLType.running) else {
            return nil
        }
        return fetch(runningURLRequest, defaultValue: [Matches]()).eraseToAnyPublisher()
    }
    
    // MARK: - Private Functions
    
    /// Prepare URL Request with specific string
    /// - Parameters:
    ///   - ofType: Type of url to be requested
    ///   - teamId: if a team url, which team
    ///   - page: page to fetch
    /// - Returns: Requested URL with headers
    private func getURLRequest(ofType: URLType, teamId: String = "", page: String = "") -> URLRequest? {
        switch ofType {
        case .running:
            guard let urlRunning = URL(string: StringConstants.runningMatchesUrl) else {
                return nil
            }
            let urlRequestRunning = setUrlWithString(urlRunning)
            return urlRequestRunning
        case .upcoming:
            guard let urlUpcoming = URL(string: "\(StringConstants.upcomingMatchesUrl)\(page)") else {
                return nil
            }
            let urlRequestUpcoming = setUrlWithString(urlUpcoming)
            return urlRequestUpcoming
        case .team:
            guard let teamUrl = URL(string: "\(StringConstants.teamUrl)\(teamId)") else {
                return nil
            }
            let urlRequestTeam = setUrlWithString(teamUrl)
            return urlRequestTeam
        }
    }
    
    ///  Create URL Request
    /// - Parameter url: url string
    /// - Returns: Requested URL with headers
    private func setUrlWithString(_ url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        return urlRequest
    }
    
    func fetch<T: Decodable>(_ url: URLRequest, defaultValue: T) -> AnyPublisher<T,Never> {
        // TODO: check for internet connectivity with NWPathMonitor and display alert with Retry
        
        let decoder = JSONDecoder()
        return URLSession.shared.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .replaceError(with: defaultValue)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
