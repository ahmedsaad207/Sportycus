//
//  TennisDetailsResponse.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation

struct TennisDetailsResponse: Decodable, ResponseProtocol{
    let result: [TennisFixture]?
}


struct TennisFixture: Decodable {
    let key: Int
    let date, time, firstPlayer: String?
    let firstPlayerKey: Int
    let secondPlayer: String?
    let secondPlayerKey: Int
    let finalResult: String?
    let gameResult: String?
    let status: String?
    let firstPlayerLogo, secondPlayerLogo: String?


    enum CodingKeys: String, CodingKey {
        case key = "event_key"
        case date = "event_date"
        case time = "event_time"
        case firstPlayer = "event_first_player"
        case firstPlayerKey = "first_player_key"
        case secondPlayer = "event_second_player"
        case secondPlayerKey = "second_player_key"
        case finalResult = "event_final_result"
        case gameResult = "event_game_result"
        case status = "event_status"
        case firstPlayerLogo = "event_first_player_logo"
        case secondPlayerLogo = "event_second_player_logo"
    }
}
