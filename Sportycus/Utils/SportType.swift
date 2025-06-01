//
//  SportsType.swift
//  Sportycus
//
//  Created by Youssif Nasser on 31/05/2025.
//

import Foundation


enum SportType : String{
    case football = "Football"
    case tennis = "Tennis"
    case cricket = "Cricket"
    case basketball = "Basketball"
    
    var path: String {
        switch self {
        case .football: return "football"
        case .tennis: return "tennis"
        case .cricket: return "cricket"
        case .basketball: return "basketball"
        }
    }
    
    func decodeResponse(from data: Data) -> ResponseProtocol? {
        switch self {
        case .football:
            return try? JSONDecoder().decode(FootballDetailsResponse.self, from: data)
        case .tennis:
            return try? JSONDecoder().decode(TennisDetailsResponse.self, from: data)
        case .cricket:
            return try? JSONDecoder().decode(CricketDetailsResponse.self, from: data)
        case .basketball:
            return try? JSONDecoder().decode(BasketballDetailsResponse.self, from: data)
        }
    }
}
