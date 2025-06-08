import Foundation


protocol LeaguePresenterProtocol{
    func getLeagues()
    func getLeaguesCount()->Int
    func getSportType() -> SportType
    func league(at index: Int) -> League
   
}

class LeaguePresenter: LeaguePresenterProtocol {

    var vc: LeagueViewProtocol?
    private var leagues: [League] = []
    private var sportType: SportType

    init(vc: LeagueViewProtocol, sportType: SportType) {
        self.vc = vc
        self.sportType = sportType
    }

    func getSportType() -> SportType {
        return sportType
    }

    func getLeaguesCount() -> Int {
        leagues.count
    }

    func league(at index: Int) -> League {
        leagues[index]
    }

    func getLeagues() {
        LeagueService().getLeagues(completion: { [weak self] leaguesResponse in
            guard let self = self else { return }
            if let response = leaguesResponse {
                self.leagues = response.result
                DispatchQueue.main.async {
                    self.vc?.renderToView(data: response.result)
                }
            }
        }, sport: sportType.path)
    }
}
