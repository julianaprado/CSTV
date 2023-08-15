//
//  MatchDetailsViewModel.swift
//  CSTV
//
//  Created by Juliana Prado on 13/08/23.
//

import Foundation
import SwiftUI
import Combine

/// Match Details View Model
final class MatchDetailsViewModel: ObservableObject {
    
    // MARK: - Properties
    private var requests = Set<AnyCancellable>()
    var networkManager: NetworkManager
    var opponents: [Opponents]
    var howMany: HowManyOpponents
    var time: String
    
    @Published var isLoading: Bool = true
    @Published var teamOne = [Team]()
    @Published var teamTwo = [Team]()
    
    // MARK: - Initializers
    init(manager: NetworkManager, teams: [Opponents], howManyOpponents: HowManyOpponents, time: String) {
        self.opponents = teams
        self.networkManager = manager
        self.howMany = howManyOpponents
        self.time = time
    }
    
    // MARK: - Functions
    
    /// Fetches available teams from the API
    func getTeams() {
        switch howMany {
        case .one:
            guard let teamOne = networkManager.getTeams(withID: String(opponents[0].getTeamId())) else {
                return
            }
            teamOne
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.showActivityIndicator()
                    case .failure:
                        self?.showActivityIndicator()
                    }
                } receiveValue: { [weak self] team in
                    self?.teamOne = team
                } .store(in: &requests)
            
        case .two:
            guard let teamOne = networkManager.getTeams(withID: String(opponents[0].getTeamId())),
                  let teamTwo = networkManager.getTeams(withID: String(opponents[1].getTeamId())) else {
                return
            }
            
            let combined = Publishers.Zip(teamOne, teamTwo)
            combined
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] _ in
                    self?.showActivityIndicator()
                }, receiveValue: { [weak self] one, two in
                    self?.teamOne = one
                    self?.teamTwo = two
                }) .store(in: &requests)
        case .none:
            self.showActivityIndicator()
        }
    }
    
    /// Get First Opponent
    /// - Returns: First Opponent
    func getFirstOpponent() -> Opponents? {
        if howMany != .none {
            return opponents[0]
        }
        return nil
    }
    
    /// Get Second Opponent
    /// - Returns: Second Opponent
    func getSecondOpponent() -> Opponents? {
        if howMany == .two {
            return opponents[1]
        }
        return nil
    }
    
    /// Toggle Main Activity Indicator
    func showActivityIndicator() {
        self.isLoading = false
    }
    
    /// Get Player name, nick and image
    /// - Parameters:
    ///   - index: index of the player
    ///   - ofTeam: which team
    /// - Returns: array where: [Nickname, Full Name, Image URL]
    func getPlayerStats(index: Int, ofTeam: OpponentEnum) -> [String] {
        switch ofTeam {
        case .first:
            return getPlayerStatsArray(index: index, teamArray: teamOne)
        case .second:
           return getPlayerStatsArray(index: index, teamArray: teamTwo)
        }
    }
    
    // MARK: - Private Functions
    
    /// Generic getter of player name, nick and image
    /// - Parameters:
    ///   - index: index of player
    ///   - teamArray: which team
    /// - Returns: array where: [Nickname, Full Name, Image URL]
    private func getPlayerStatsArray(index: Int, teamArray: [Team]) -> [String] {
        let emptyArray = [StringConstants.nickName,StringConstants.fullName,""]
        if teamArray.count == 0 {
            return emptyArray
        }
        guard let count = teamArray[0].players?.count else {
            return emptyArray
        }
        if index >= 0 && count > index {
            let fullName = makeFullName(firstName: teamArray[0].players?[index].getFirstName() ?? "",
                                        lastName: teamArray[0].players?[index].getLastName() ?? "")
            return [teamArray[0].players?[index].getNick() ?? "",
                    fullName,
                    teamArray[0].players?[index].getImageURL() ?? ""]
        } else {
            return emptyArray
        }
    }
    
    /// Simple Full Name String Preparation
    /// - Parameters:
    ///   - first: First Name
    ///   - last: Last Name
    /// - Returns: Concatenation of first and last
    private func makeFullName(firstName first: String, lastName last: String) -> String {
        return "\(first) \(last)"
    }
}
