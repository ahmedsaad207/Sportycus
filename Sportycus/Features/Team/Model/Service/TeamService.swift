import Foundation

protocol TeamServiceProtocol {
    func getTeam(completion: @escaping (TeamResponse?) -> Void, sport: String, teamKey: Int, leagueId: Int)
}

class TeamService : TeamServiceProtocol {
    
    func getTeam(completion:@escaping (TeamResponse?) -> Void, sport: String, teamKey: Int, leagueId: Int) {
        let baseUrl = "https://apiv2.allsportsapi.com/"
        let apiKey = "586f22d0c8d25e87a307eb2b356adf784613495adeb6e3f00403fd33c481b2d2"
        let url = "\(baseUrl)\(sport)?met=Teams&leagueId=\(leagueId)&teamId=\(teamKey)&APIkey=\(apiKey)"
        
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) {data,response ,error in
            guard let data = data else {return}
            do {
                let res = try JSONDecoder().decode(TeamResponse.self, from: data)
                completion(res)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
}
