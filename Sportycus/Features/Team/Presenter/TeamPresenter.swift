import Foundation

protocol TeamPresenterProtocol {
    func getTeam(sport: String, teamKey: Int, leagueId: Int)
}

class TeamPresenter : TeamPresenterProtocol{
    var vc:TeamViewProtocol!
    
    init(vc: TeamViewProtocol!) {
        self.vc = vc
    }
    
    func getTeam(sport: String, teamKey: Int, leagueId: Int) {
        TeamService().getTeam(completion: { response in
            if let response = response {
                self.vc.renderToView(response: response)
            }
        }, sport: sport, teamKey: teamKey, leagueId: leagueId)
    }
}
