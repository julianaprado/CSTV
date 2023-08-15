//
//  StringConstants.swift
//  CSTV
//
//  Created by Juliana Prado on 08/08/23.
//

import Foundation

struct StringConstants {
    
    // MARK: - Api Strings
    
    // Bearer Token
    static let apiToken = "DJQlw4yU8VSt9CsImY77d0NaeEiS2e7JO8zDkAW4XTpQ0emMWyU"
    
    // Running Matches url
    static let runningMatchesUrl = "https://api.pandascore.co/csgo/matches/running"
    
    // Upcoming Matches url
    static let upcomingMatchesUrl = "https://api.pandascore.co/csgo/matches/upcoming?page[number]="
    
    // Team Matches url without team id
    static let teamUrl = "https://api.pandascore.co/csgo/teams?filter[id]="
    
    // MARK: - View Strings
    
    // View navigation title
    static let matchesNavigationTitle = "Partidas"
    
    // String to replace names when the match details is yet to be decided
    static let toBeDecided = "TBD"
    
    // Player nick in the game
    static let nickName = "Nickname"
    
    // TBD player fill in name
    static let fullName = "Player Name"
    
    // Icon to substitute team and league images
    static let circle = "circle.fill"
    
    // static vs string between two teams
    static let vs = "vs"
    
    // custom back button icon
    static let backArrow = "arrow.backward"
    
    // Icon to substitute player image
    static let square = "app.fill"
    
    // MARK: - Date Formatt String
    
    // Api date format
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    
    // Api timezone
    static let timeZone = "UTC"
    
    // Hour and minute 
    static let hourAndMinute = "HH:mm"
    
    // Day of the week and hour and minute
    static let dayofWeek = "E, \(hourAndMinute)"
    
    // Substitute Today string when match is live
    static let now = "AGORA"
    
    // Day and month and hour and minute
    static let dayOfMonth = "dd.MM, \(hourAndMinute)"
}
