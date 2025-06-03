//
//  LeagueDetails.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation

protocol LeagueDetailsPresenterProtocol {
    func getLeagueDetails()
    func getLeague()
    func addLeague(league: League, sportType: String)
    func deleteLeague(key: Int)
    func getSportType()->SportType
    func isLeagueExist(leagueKey: Int)
}

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {

    

    
    var view: LeagueDetailsViewProtocol!
    var sportType: SportType!
    var league: League!
        
    init(view: LeagueDetailsViewProtocol!, sportType: SportType, league:League) {
        self.sportType = sportType
        self.view = view
        self.league = league
        getLeague()
    }
    
    let local = LeagueLocalDataSource()
    
    func isLeagueExist(leagueKey: Int) {
        view.onLeagueCheckedIfCached(cached: local.isLeagueExist(leagueKey: leagueKey))
    }
    
    func addLeague(league: League, sportType: String) {
        local.addLeague(league: league, sportType: sportType)
    }
    
    func deleteLeague(key: Int) {
        local.deleteLeague(key: key)
    }
    
    func getSportType()->SportType {
        return self.sportType
    }
    
    func getLeague(){
        view.getCurrentLeague(league: league)
    }
    
    
    func getLeagueDetails() {
        LeagueDetailsService.getLeagueDetails(for: sportType, leagueID: league.league_key!) { res in
            guard let res = res else {
                print("Failed to get data")
                return
            }
            
             let leagueID = self.league.league_key!
            print(leagueID)
            self.getLeagueTeams(leagueId: leagueID, sportName: self.sportType.path)
            
            DispatchQueue.main.async {
                switch self.sportType {
                case .tennis:
                    if let tennisRes = res as? TennisDetailsResponse {
                        
                        let (old, upcoming) = self.filteredEvents(unFilteredList: tennisRes.result ?? [])
                        
                        self.view.displayData(data: (old,upcoming))
                    }

                case .football:
                    if let footballRes = res as? FootballDetailsResponse {
                        
                        let (old, upcoming) = self.filteredEvents(unFilteredList: footballRes.result ?? [])
                        
                        print(old.count,upcoming.count)
                        self.view.displayData(data: (old,upcoming))

                    }

                case .basketball:
                    if let basketballRes = res as? BasketballDetailsResponse {
                        
                        let (old, upcoming) = self.filteredEvents(unFilteredList: basketballRes.result ?? [])
                        
                        self.view.displayData(data: (old,upcoming))

                    }

                case .cricket:
                    if let cricketRes = res as? CricketDetailsResponse {

                        let (old, upcoming) = self.filteredEvents(unFilteredList: cricketRes.result ?? [])
                        
                        self.view.displayData(data: (old,upcoming))
                    }
                case .none:
                    print("===none====")
                }
            }
        }
    }
    
    private func getLeagueTeams(leagueId: Int, sportName: String){
        LeagueTeamsService.getTeamsByLeagueId(completion: { teamResponse in

            print("TEAM COUNT \(teamResponse?.result.count)")
            self.view.displayTeam(team: teamResponse?.result ?? [])
        }, leagueId: leagueId, sportName: sportName)
    }
    
    
    private func filteredEvents<T: DateFilter>(unFilteredList: [T]) -> ([T], [T]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current

        let today = Calendar.current.startOfDay(for: Date())

        let oldEvents = unFilteredList.filter { fixture in
            guard let dateString = fixture.date,
                  let fixtureDate = dateFormatter.date(from: dateString) else {
                return false
            }
            return fixtureDate < today
        }

        let upcomingEvents = unFilteredList.filter { fixture in
            guard let dateString = fixture.date,
                  let fixtureDate = dateFormatter.date(from: dateString) else {
                return false
            }
            return fixtureDate >= today
        }

        return (oldEvents, upcomingEvents)
    }

}
