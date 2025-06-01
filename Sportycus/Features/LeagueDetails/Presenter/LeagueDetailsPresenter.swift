//
//  LeagueDetails.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation

protocol LeagueDetailsPresenterProtocol {
    func getLeagueDetails()
//    func getLeagueByKey() -> League
    func addLeague(league: League)
    func deleteLeague(key: Int)
    func getSportType()->SportType
}

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {
    
    var view: LeagueDetailsViewProtocol!
    var sportType: SportType!
    var leagueID: Int!
        
    init(view: LeagueDetailsViewProtocol!, sportType: SportType, leagueID: Int) {
        self.sportType = sportType
        self.view = view
        self.leagueID = leagueID
    }
    
//    let local = LeagueLocalDataSource()


//    func getLeagueByKey() -> League {
//        local.getLeagueByKey()
//    }
    
    func addLeague(league: League) {
//        local.addLeague(league: league)
    }
    
    func deleteLeague(key: Int) {
//        local.deleteLeague(key: key)
    }
    
    func getSportType()->SportType {
        return self.sportType
    }
    
    func getLeagueDetails() {
        LeagueDetailsService.getLeagueDetails(for: sportType, leagueID: leagueID) { res in
            guard let res = res else {
                print("Failed to get data")
                return
            }

            DispatchQueue.main.async {
                print(self.leagueID)
                switch self.sportType {
                case .tennis:
                    if let tennisRes = res as? TennisDetailsResponse {
                        print("------------------------\(tennisRes.result?.first)")
                        self.view.displayData(data: tennisRes.result ?? [])
                    }

                case .football:
                    if let footballRes = res as? FootballDetailsResponse {
                        self.view.displayData(data: footballRes.result ?? [])
                        print("------------------------\(footballRes.result?.first)")

                    }

                case .basketball:
                    if let basketballRes = res as? BasketballDetailsResponse {
                        self.view.displayData(data: basketballRes.result ?? [])
                        print("------------------------\(basketballRes.result?.first)")

                    }

                case .cricket:
                    if let cricketRes = res as? CricketDetailsResponse {
                        self.view.displayData(data: cricketRes.result ?? [])
                        print("------------------------\(cricketRes.result?.first)")

                    }
                case .none:
                    print("===none====")
                }
            }
        }
    }
}
