import Foundation

protocol LeagueServiceProtocol {
    func getLeagues(completion: @escaping (LeagueResponse?) -> Void, sport: String)
}

class LeagueService : LeagueServiceProtocol{
    func getLeagues(completion: @escaping (LeagueResponse?) -> Void, sport: String) {
        URLSession.shared.dataTask(with: URLRequest(url: URL(string: "https://apiv2.allsportsapi.com/\(sport)?met=Leagues&APIkey=586f22d0c8d25e87a307eb2b356adf784613495adeb6e3f00403fd33c481b2d2")!)) { data, response, error in
            guard let data = data else {return}
            
            do {
                let res = try JSONDecoder().decode(LeagueResponse.self, from: data)
                //print(res)
                completion(res)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
}
