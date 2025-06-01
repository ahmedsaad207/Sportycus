import Foundation


protocol LeaguePresenterProtocol{
    func getLeagues()
    func getLeaguesCount()->Int
    func getSportType() -> SportType
    func league(at index: Int) -> League
}


class LeaguePresenter: LeaguePresenterProtocol {
    
    
    
    var vc:LeagueViewProtocol?
    
    var leagues: [League] = []
    
    private var sportType: SportType!
    
    init(vc: LeagueViewProtocol, sportType: SportType) {
        self.vc = vc
        self.sportType = sportType
    }
    
    func getLeaguesCount() -> Int {
        self.leagues.count
    }
    
    func league(at index: Int) -> League {
        return leagues[index]
    }
    
    func getSportType() -> SportType {
        return sportType
    }
    
    func getLeagues() {
        LeagueService().getLeagues(completion: { leaguesResponse in
            if let response = leaguesResponse {
                self.leagues = response.result
                self.vc!.renderToView(data: response.result)
            }
        }, sport: sportType.path)
    }
}

