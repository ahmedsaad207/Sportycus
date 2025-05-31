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
        Sport(sportTitle: "Football", sportImage: "football"),
        Sport(sportTitle: "Basketball", sportImage: "basketball"),
        Sport(sportTitle: "Tennis", sportImage: "tennis"),
        Sport(sportTitle: "Cricket", sportImage: "cricket")
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
        view?.navigateToLeague(sport: sports[index].sportTitle.lowercased())
    }
}
