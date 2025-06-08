import Foundation
import CoreData
import UIKit

class LeaguesCoreData {
    static let shared = LeaguesCoreData()
    var persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    

    func deleteLeague(key: Int) {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        request.predicate = NSPredicate(format: "leagueKey == %d", key)
        
        do {
            let results = try context.fetch(request)
            if let leagueToDelete = results.first {
                context.delete(leagueToDelete)
                try context.save()
            } else {
                print("League not found")
            }
        } catch {
            print("Failed to delete league:", error.localizedDescription)
        }
    }
    
    func addLeague(league: League, sportType: String) {
        
        let context = persistentContainer.viewContext
        
        do {
            let newLeague = FavoriteLeague(context: context)
            newLeague.leagueKey = Int64(league.league_key ?? 0)
            newLeague.leagueName = league.league_name
            newLeague.leagueLogo = league.league_logo
            newLeague.leagueCountry = league.country_name
            newLeague.sportType = sportType
            newLeague.isFavorite = true
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getLeagues() -> [FavoriteLeague]{
        let context = persistentContainer.viewContext
        let request = FavoriteLeague.fetchRequest()
        
        do {
            let leagues = try context.fetch(request)
            return leagues
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    func isLeagueExist(leagueKey: Int) -> Bool {
        let context = persistentContainer.viewContext
        let request = FavoriteLeague.fetchRequest()
        request.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)
        request.fetchLimit = 1

        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            print("Failed to check existence:", error.localizedDescription)
            return false
        }
    }

    
}
