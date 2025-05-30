//
//  BasketBallDetailsResponse.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation

struct BasketballDetailsResponse: Decodable , ResponseProtocol{
    let result: [BasketballFixture]?
}

struct BasketballFixture : Decodable {
        let key: Int
        let date, time, homeTeam: String?
        let homeTeamKey: Int
        let awayTeam: String?
        let awayTeamKey: Int
        let finalResult: String?
        let status: String?
        let homeTeamLogo, awayTeamLogo: String?

        enum CodingKeys: String, CodingKey {
            case key = "event_key"
            case date = "event_date"
            case time = "event_time"
            case homeTeam = "event_home_team"
            case homeTeamKey = "home_team_key"
            case awayTeam = "event_away_team"
            case awayTeamKey = "away_team_key"
            case finalResult = "event_final_result"
            case status = "event_status"
            case homeTeamLogo = "event_home_team_logo"
            case awayTeamLogo = "event_away_team_logo"
    }
}
