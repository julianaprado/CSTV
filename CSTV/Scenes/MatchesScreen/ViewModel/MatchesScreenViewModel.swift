//
//  MatchesScreenViewModel.swift
//  CSTV
//
//  Created by Juliana Prado on 11/08/23.
//

import Foundation
import SwiftUI
import Combine

/// Match List View Model
final class MatchesScreenViewModel: ObservableObject {
    
    // MARK: - Properties
    private var requests = Set<AnyCancellable>()
    var networkManager: NetworkManager = NetworkManager()
    
    @Published var shouldStopPagination: Bool = false
    private var page = 1
    
    var timer = Timer()
    
    @Published var isLoading: Bool = true
    @Published var allMatches: [Matches] = []
    
    // MARK: - Public Functions
    
    /// Get upcoming and running matches
    func addSubscriber() {
        page = 1
        guard let upcoming = networkManager.getUpcomingMatches(page: page),
              let running = networkManager.getRunningMatches() else {
            return
        }
        let combined = Publishers.Zip(upcoming, running)
        combined
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.showActivityIndicator()
                    
                case .failure:
                    self?.showActivityIndicator()
                }
            }, receiveValue: { [weak self] upc, run in
                self?.allMatches = (self?.removeMatchesWithoutTimeStamp(fromArray: run))!
                self?.allMatches.append(contentsOf: (self?.removeMatchesWithoutTimeStamp(fromArray: upc))!)
                self?.setTimer()
            }) .store(in: &requests)
        
    }
    
    /// Get more upcoming matches for pagination
    /// Running matches wont be fetched, they can be updated with the pull to refresh
    func getMoreUpcomingMatches() {
        page += 1
        if page > 10 {
            return
        }
        guard let upcoming = networkManager.getUpcomingMatches(page: page) else {
            return
        }
        
        // With completion
        upcoming
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.hidePagination()
                case .failure:
                    self?.hidePagination()
                }
            } receiveValue: { [weak self] new in
                if new.count != 0 {
                    self?.allMatches.append(contentsOf: new)
                } else {
                    self?.hidePagination()
                }
            } .store(in: &requests)
    }
    
    /// Format the time stamp
    /// - Parameter dateString: date recieved from the API
    /// - Returns: string to be shown on screen
    func formatDateString(_ dateString: String, index: Int) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = StringConstants.dateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: StringConstants.timeZone)
        
        if let date = dateFormatter.date(from: dateString) {
            let currentTime = Date()
            let calendar = Calendar.current
            
            dateFormatter.timeZone = TimeZone.current
            
            if calendar.isDateInToday(date) {
                if date <= currentTime {
                    if self.allMatches[index].getIsLive() == false {
                        self.allMatches[index].setIsLiveBool(with: true)
                        self.allMatches[index].setTimeString(with: StringConstants.now)
                        let element = self.allMatches[index]
                        allMatches.remove(at: index)
                        allMatches.insert(element, at: 0)
                    } else {
                        self.allMatches[index].setIsLiveBool(with: true)
                        self.allMatches[index].setTimeString(with: StringConstants.now)
                    }
                } else {
                    dateFormatter.dateFormat = StringConstants.hourAndMinute
                    let formattedTime =  dateFormatter.string(from: date)
                    self.allMatches[index].setIsLiveBool(with: false)
                    self.allMatches[index].setTimeString(with: "Hoje, \(formattedTime)")
                }
            } else if calendar.isDate(date, equalTo: Date(), toGranularity: .weekOfYear) {
                dateFormatter.dateFormat = StringConstants.dayofWeek
                let formattedString = dateFormatter.string(from: date)
                self.allMatches[index].setIsLiveBool(with: false)
                self.allMatches[index].setTimeString(with: formattedString.capitalized.replacingOccurrences(of: ".", with: ""))
            } else {
                dateFormatter.dateFormat = StringConstants.dayOfMonth
                let formattedString = dateFormatter.string(from: date)
                self.allMatches[index].setIsLiveBool(with: false)
                self.allMatches[index].setTimeString(with: formattedString)
            }
        }
    }
    
    /// Toggle Main Activity Indicator
    func showActivityIndicator() {
        self.isLoading = false
    }
    
    /// Toggle Pagination Activity Indicator
    func hidePagination() {
        self.shouldStopPagination = true
    }
    
    // MARK: - Private Functions
    
    /// Remove matches without time stamp
    /// - Parameter array: array to remove from
    /// - Returns: new array
    private func removeMatchesWithoutTimeStamp(fromArray array: [Matches]) -> [Matches] {
        let new = array.filter { $0.beginsAt != nil }
        return new
    }
    
    public func stopTimer() {
        timer.invalidate()
    }
    
    private func setTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.checkMatchTimeRelativeToDate()
        }
    }
    
    private func checkMatchTimeRelativeToDate() {
        for i in allMatches.indices {
            self.formatDateString(self.allMatches[i].getTime(), index: i)
        }
    }
    
}
