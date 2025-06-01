//
//  HomePresenter.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation

protocol HomePresenterProtocol {
    var sportsCount: Int { get }
    func sport(at index: Int) -> Sport
    func didSelectSport(at index: Int)
}


class HomePresenter: HomePresenterProtocol {
    
    private var view: HomeViewProtocol?
    
    private let sports: [Sport] = [
        Sport(sportTitle: SportType.football.rawValue, sportImage: "football"),
        Sport(sportTitle: SportType.basketball.rawValue, sportImage: "basketball"),
        Sport(sportTitle: SportType.tennis.rawValue, sportImage: "tennis"),
        Sport(sportTitle: SportType.cricket.rawValue, sportImage: "cricket")
    ]
    
    init(view: HomeViewProtocol) {
        self.view = view
    }

    var sportsCount: Int {
        return sports.count
    }

    func sport(at index: Int) -> Sport {
        return sports[index]
    }

    func didSelectSport(at index: Int) {
        guard let sType = SportType(rawValue: sports[index].sportTitle) else {return}
        view?.navigateToLeague(sport: sType)
    }
    
    
}
