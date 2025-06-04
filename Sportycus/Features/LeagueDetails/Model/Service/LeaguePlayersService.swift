import Foundation

protocol LeaguePlayersProtocol {
    static func getPlayersByLeagueId(completion: @escaping (PlayerResponse?) -> Void, leagueId: Int, sportName: String)
}

class LeaguePlayersService : LeaguePlayersProtocol{
    static func getPlayersByLeagueId(completion: @escaping (PlayerResponse?) -> Void, leagueId: Int, sportName: String) {
        let APIkey = "586f22d0c8d25e87a307eb2b356adf784613495adeb6e3f00403fd33c481b2d2"
        let baseUrl = "https://apiv2.allsportsapi.com/"
        let url = "\(baseUrl)tennis?met=Players&APIkey=\(APIkey)&leagueId=\(leagueId)"
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { data, response, error in
            guard let data = data else {return}
            
            do {
                let res = try JSONDecoder().decode(PlayerResponse.self, from: data)
//                print(res)
                completion(res)
            } catch  {
                print("ERROR IN LEAGUE TEAMS: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
