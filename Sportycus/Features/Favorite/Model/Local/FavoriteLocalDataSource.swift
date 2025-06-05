import Foundation

class FavoriteLocalDataSource {
    let coreData = LeaguesCoreData.shared
    func getLeagues() -> [FavoriteLeague] {
        return coreData.getLeagues()
    }

    func deleteLeague(key: Int) {
        coreData.deleteLeague(key: key)
    }
}

