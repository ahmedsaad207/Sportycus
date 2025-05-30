//
//  LeagueDetails.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation

protocol LeagueDetailsPresenterProtocol {
    func getLeagueDetails(sport: String, leagueID: String)
}

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {
    
    var view: LeagueDetailsViewProtocol!
    
    private var list: [ResponseProtocol]!
    
    init(view: LeagueDetailsViewProtocol!) {
        self.view = view
    }
    
    func getLeagueDetails(sport: String, leagueID: String) {
        LeagueDetailsService.getLeagueDetails(completion: { data in

            
        }, sport: sport, leagueID: leagueID)
    }
    
    
    
    
}
