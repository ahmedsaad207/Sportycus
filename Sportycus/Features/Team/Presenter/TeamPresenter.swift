import Foundation

protocol TeamPresenterProtocol {
    func getTeam(sport: String, teamKey: Int, leagueId: Int)
}

class TeamPresenter : TeamPresenterProtocol{
    var vc:TeamViewProtocol!
    var sportType: SportType!
    
    
    
    init(vc: TeamViewProtocol!, sportType: SportType) {
        self.vc = vc
        self.sportType = sportType
        
        self.vc.sport(sportType: sportType)
    }
    
    func getTeam(sport: String, teamKey: Int, leagueId: Int) {
        TeamService().getTeam(completion: { response in
            if let response = response {
                self.vc.renderToView(response: response)
            }
        }, sport: sport, teamKey: teamKey, leagueId: leagueId)
    }
}
