//
//  LeagueService.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation
protocol LeagueDetailsServiceProtocol {
    static func getLeagueDetails(for sport: SportType, leagueID: Int, completion: @escaping (ResponseProtocol?) -> Void)
}

class LeagueDetailsService: LeagueDetailsServiceProtocol {
    
    static func getLeagueDetails(for sport: SportType, leagueID: Int, completion: @escaping (ResponseProtocol?) -> Void) {
        let baseUrl = "https://apiv2.allsportsapi.com/"
        let apiKey = "586f22d0c8d25e87a307eb2b356adf784613495adeb6e3f00403fd33c481b2d2"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let from = formatter.string(from: Calendar.current.date(byAdding: .year, value: -1, to: Date())!)
        let to = formatter.string(from: Calendar.current.date(byAdding: .year, value: 1, to: Date())!)
        
        let urlString = "\(baseUrl)\(sport.path)?met=Fixtures&from=\(from)&to=\(to)&leagueId=\(leagueID)&APIkey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil)
                print(error?.localizedDescription)
                return
            }
            
            let decoded = sport.decodeResponse(from: data)
            completion(decoded)
            
        }.resume()
    }
    

}

