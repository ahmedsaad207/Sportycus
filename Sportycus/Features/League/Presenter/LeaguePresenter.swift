import Foundation

protocol LeagueProtocol {
    func renderToView(response: LeagueResponse)
}

class LeaguePresenter {
    var vc:LeagueProtocol!
    
    init(vc: LeagueProtocol!) {
        self.vc = vc
    }
    
    func getLeagues(sport: String) {
        LeagueService().getLeagues(completion: { leaguesResponse in
            if let response = leaguesResponse {
                self.vc.renderToView(response: response)
            }
        }, sport: sport)
    }
}
