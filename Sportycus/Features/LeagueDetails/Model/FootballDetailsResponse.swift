// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let leagueDetailsResponse = try? JSONDecoder().decode(LeagueDetailsResponse.self, from: jsonData)

import Foundation


struct FootballDetailsResponse: Decodable , ResponseProtocol{
    let result: [FootballFixture]?
}


struct FootballFixture :Decodable{
        let key: Int
        let date: String?
        let time: String?
        let homeTeam: String?
        let homeTeamKey: Int
        let awayTeam: String?
        let awayTeamKey: Int
        let finalResult : String?
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
            case homeTeamLogo = "home_team_logo"
            case awayTeamLogo = "away_team_logo"
    }
}


