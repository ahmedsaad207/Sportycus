//
//  ChricketDetailsResponse.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation

struct CricketDetailsResponse :Decodable, ResponseProtocol {
    let result: [CricketFixture]?
}

struct CricketFixture: Decodable {
    let key: Int
    let dateStart, dateStop, time, homeTeam: String?
    let homeTeamKey: Int
    let awayTeam: String?
    let awayTeamKey: Int
    let homeFinalResult, awayFinalResult: String?
    let status: String?
    let stadium: String?
    let homeTeamLogo, awayTeamLogo: String?


    enum CodingKeys: String, CodingKey {
        case key = "event_key"
        case dateStart = "event_date_start"
        case dateStop = "event_date_stop"
        case time = "event_time"
        case homeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case awayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case homeFinalResult = "event_home_final_result"
        case awayFinalResult = "event_away_final_result"
        case status = "event_status"
        case stadium = "event_stadium"
        case homeTeamLogo = "event_home_team_logo"
        case awayTeamLogo = "event_away_team_logo"
    }
}

extension CricketFixture: DateFilter {
    var date: String? {
        return dateStart
    }
}
