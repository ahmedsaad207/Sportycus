import Foundation

class LeagueLocalDataSource {
    let coreData = LeaguesCoreData()
    func isLeagueExist(leagueKey: Int) -> Bool {
        return coreData.isLeagueExist(leagueKey: leagueKey)
    }

    func addLeague(league: League, sportType: String) {
        coreData.addLeague(league: league, sportType: sportType)
    }
    
    func deleteLeague(key: Int) {
        coreData.deleteLeague(key: key)
    }
}

