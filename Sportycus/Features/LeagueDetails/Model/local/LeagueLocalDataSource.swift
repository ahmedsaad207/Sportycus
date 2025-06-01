import Foundation

class LeagueLocalDataSource {
    let coreData = LeaguesCoreData()
    func isLeagueExist(leagueKey: Int) -> Bool {
        return coreData.isLeagueExist(leagueKey: leagueKey)
    }

    func addLeague(league: League) {
        coreData.addLeague(league: league)
    }
    
    func deleteLeague(key: Int) {
        coreData.deleteLeague(key: key)
    }
}

