//
//  LeagueService.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation
protocol LeagueDetailsServiceProtocol {
    static func getLeagueDetails(completion: @escaping (ResponseProtocol?) -> Void, sport: String, leagueID: String)
}

class LeagueDetailsService: LeagueDetailsServiceProtocol {
    
    static func getLeagueDetails(completion:@escaping (ResponseProtocol?) -> Void, sport: String, leagueID: String) {
        let baseUrl = "https://apiv2.allsportsapi.com/"
        let apiKey = "586f22d0c8d25e87a307eb2b356adf784613495adeb6e3f00403fd33c481b2d2"

        let currentDate = Date()
        let calendar = Calendar.current

        let lastYearDate = calendar.date(byAdding: .year, value: -1, to: currentDate)!
        let nextYearDate = calendar.date(byAdding: .year, value: 1, to: currentDate)!

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        let lastYear = formatter.string(from: lastYearDate)
        let nextYear = formatter.string(from: nextYearDate)

        let urlString = "\(baseUrl)\(sport)?met=Fixtures&from=\(lastYear)&to=\(nextYear)&leagueId=\(leagueID)&APIkey=\(apiKey)"

        print(urlString)
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil)
                return
            }

            do {
                let res: Any
                
                switch sport.lowercased() {
                case "football":
                    res = try JSONDecoder().decode(FootballDetailsResponse.self, from: data)
                    completion(res as? ResponseProtocol)
                case "basketball":
                    res = try JSONDecoder().decode(BasketballDetailsResponse.self, from: data)
                    completion(res as? BasketballDetailsResponse)
                case "cricket":
                    res = try JSONDecoder().decode(CricketDetailsResponse.self, from: data)
                    completion(res as? CricketDetailsResponse)
                case "tennis":
                    res = try JSONDecoder().decode(TennisDetailsResponse.self, from: data)
                    completion(res as? TennisDetailsResponse)
                default:
                    print("Unsupported sport type")
                    completion(nil)
                    return
                }
                
                print(res)
                
            } catch {
                print("Decoding error:", error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
}

