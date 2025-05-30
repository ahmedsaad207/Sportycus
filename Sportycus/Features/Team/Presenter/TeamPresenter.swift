import Foundation

protocol TeamPresenterProtocol {
    func getTeam(sport: String, teamName: String, leagueId: Int)
}

class TeamPresenter : TeamPresenterProtocol{
    var vc:TeamViewProtocol!
    
    init(vc: TeamViewProtocol!) {
        self.vc = vc
    }
    
    func getTeam(sport: String, teamName: String, leagueId: Int) {
        TeamService().getTeam(completion: { response in
            if let response = response {
                self.vc.renderToView(response: response)
            }
        }, sport: sport, teamName: teamName, leagueId: leagueId)
    }
}
