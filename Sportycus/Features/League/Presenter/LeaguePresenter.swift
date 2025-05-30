import Foundation


protocol LeaguePresenterProtocol{
    func getLeagues()
    func getLeaguesCount()->Int
    
    func league(at index: Int) -> League
}


class LeaguePresenter: LeaguePresenterProtocol {
    
    var vc:LeagueViewProtocol?
    
     var leagues: [League] = []

    var sportName: String!
    
    init(vc: LeagueViewProtocol, sportName: String) {
        self.vc = vc
        self.sportName = sportName
    }
    
    func getLeaguesCount() -> Int {
        self.leagues.count
    }
    
    func league(at index: Int) -> League {
      return leagues[index]
    }
    
    func getLeagues() {
        LeagueService().getLeagues(completion: { leaguesResponse in
            if let response = leaguesResponse {
                self.leagues = response.result
                self.vc!.renderToView(data: response.result)
            }
        }, sport: sportName)
    }
}
