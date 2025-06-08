
//
//  LeagueDetails.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation
import UIKit

protocol LeagueDetailsPresenterProtocol {
    func setupAppbar()
    func didTapFavoriteButton()
    func didSelectTeam(index: Int, navigationController: UINavigationController)
    func numberOfSections() -> Int
    func numberOfItems(section: Int) -> Int
    func fetchLeagueDetails()
    func configureTeamCell(cell: TeamsCell, index: Int)
    func configureUpcomingEventCell(cell: UpcomingEventsCell, index: Int)
    func configureLatestEventCell(cell: LatestEventsCell, index: Int)
    func shouldShowEmptyState(section: Int) -> Bool
    func getSectionTitle(section: Int) -> String
    func upcomingListCount()->Int
    func checkFavoriteStatus()
    }

class LeagueDetailsPresenter: LeagueDetailsPresenterProtocol {
    
    var view: LeagueDetailsViewProtocol?
    let league: League
    let sportType: SportType
    let localDataSource = LeaguesCoreData()
    
    var teams: [Team] = []
    var players: [Player] = []
    var footballFixtures: (latest: [FootballFixture], upcoming: [FootballFixture]) = ([], [])
    var basketballFixtures: (latest: [BasketballFixture], upcoming: [BasketballFixture]) = ([], [])
    var tennisFixtures: (latest: [TennisFixture], upcoming: [TennisFixture]) = ([], [])
    var cricketFixtures: (latest: [CricketFixture], upcoming: [CricketFixture]) = ([], [])
    var isFavorite: Bool = false
    

    init(view: LeagueDetailsViewProtocol,
         sportType: SportType,
         league: League
         ) {
        self.view = view
        self.league = league
        self.sportType = sportType
    }
    
    func setupAppbar() {
        view?.showLoadingIndicator()
        DispatchQueue.main.async {
            self.view?.setNavigationTitle(title: self.league.league_name ?? "")
        }
        checkFavoriteStatus()
        fetchLeagueDetails()
    }
    
    func checkFavoriteStatus() {
        guard let leagueKey = league.league_key else { return }
        isFavorite = localDataSource.isLeagueExist(leagueKey: leagueKey)
        DispatchQueue.main.async {
            self.view?.updateFavoriteStatus(isFavorite: self.isFavorite)
        }
    }
    
    func fetchLeagueDetails() {
        LeagueDetailsService.getLeagueDetails(for: sportType, leagueID: league.league_key!) { [weak self] res in
            guard let self = self else { return }
            
            guard let res = res else {
                print("Failed to get data")
                DispatchQueue.main.async {
                    self.view?.showError(message: "Failed to load data")
                }
                return
            }

            let leagueID = self.league.league_key!
            self.getLeagueTeams(leagueId: leagueID, sportName: self.sportType.path)
            self.handleLeagueDetailsResponse(response: res)
            self.view?.hideLoadingIndicator()
        }
    }
    
    private func getLeagueTeams(leagueId: Int, sportName: String) {
        if sportName == "tennis" {
            LeaguePlayersService.getPlayersByLeagueId(completion: { [weak self] res in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.players = res?.result ?? []
                    self.view?.displayPlayers(players: self.players)
                }
                
            }, leagueId: leagueId, sportName: sportName)
        } else {
            LeagueTeamsService.getTeamsByLeagueId(completion: { [weak self] teamResponse in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.teams = teamResponse?.result ?? []
                    self.view?.displayTeams(teams: self.teams)
                }
                
            }, leagueId: leagueId, sportName: sportName)
        }
    }
    
    private func handleLeagueDetailsResponse(response: Any) {
        DispatchQueue.main.async {
            switch self.sportType {
            case .football:
                if let footballResponse = response as? FootballDetailsResponse {
                    let (latest, upcoming) = self.filteredEvents(unFilteredList: footballResponse.result ?? [])
                    self.footballFixtures = (latest, upcoming)
                    self.view?.displayFootballFixtures(upcoming: upcoming, latest: latest)
                }
            case .basketball:
                if let basketballResponse = response as? BasketballDetailsResponse {
                    let (latest, upcoming) = self.filteredEvents(unFilteredList: basketballResponse.result ?? [])
                    self.basketballFixtures = (latest, upcoming)
                    self.view?.displayBasketballFixtures(upcoming: upcoming, latest: latest)
                }
            case .tennis:
                if let tennisResponse = response as? TennisDetailsResponse {
                    let (latest, upcoming) = self.filteredEvents(unFilteredList: tennisResponse.result ?? [])
                    self.tennisFixtures = (latest, upcoming)
                    self.view?.displayTennisFixtures(upcoming: upcoming, latest: latest)
                }
            case .cricket:
                if let cricketResponse = response as? CricketDetailsResponse {
                    let (latest, upcoming) = self.filteredEvents(unFilteredList: cricketResponse.result ?? [])
                    self.cricketFixtures = (latest, upcoming)
                    self.view?.displayCricketFixtures(upcoming: upcoming, latest: latest)
                }
            }
        }
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
    
    
    func didTapFavoriteButton() {
        if isFavorite {
            showDeleteAlert()
        } else {
            addLeague()
        }
    }
    
    private func showDeleteAlert() {
        let alert = UIAlertController(title: "Unfavorite", message: "Are you sure you want to remove from favorites?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.deleteLeague()
        }))
        view?.presentAlert(alert:alert)
    }
                                               
   
    private func addLeague() {
        guard let leagueKey = league.league_key,
              let leagueName = league.league_name else { return }
        
        let leagueToSave = League(league_key: leagueKey,
                                league_name: leagueName,
                                league_logo: league.league_logo,
                                country_name: league.country_name)
        
        localDataSource.addLeague(league: leagueToSave, sportType: sportType.rawValue)
        isFavorite = true
        view?.updateFavoriteStatus(isFavorite: isFavorite)
    }
    
    private func deleteLeague() {
        guard let leagueKey = league.league_key else { return }
        localDataSource.deleteLeague(key: Int(leagueKey))
        isFavorite = false
        view?.updateFavoriteStatus(isFavorite: isFavorite)
    }
    
    func didSelectTeam(index: Int, navigationController: UINavigationController) {
        if sportType == .basketball || sportType == .football {
            let teamStoryBoard = UIStoryboard(name: "Team", bundle: nil)
            let teamVC = teamStoryBoard.instantiateViewController(identifier: "team") as! TeamController
            let key = teams[index].team_key ?? 0
            teamVC.presenter = TeamPresenter(vc: teamVC, sportType: self.sportType, teamKey: key, leagueId: self.league.league_key!)
            navigationController.pushViewController(teamVC, animated: true)
        }
    }
    
    func numberOfSections() -> Int {
        return 3
    }
    
    func numberOfItems(section: Int) -> Int {
        switch section {
        case 0:
            return sportType == .tennis ? max(players.count, 1) : max(teams.count, 1)
        case 1:
            return upcomingEventsCount > 0 ? upcomingEventsCount : 1
        case 2:
            return latestEventsCount > 0 ? latestEventsCount : 1
        default:
            return 0
        }
    }
    
    private var upcomingEventsCount: Int {
        switch sportType {
        case .football: return footballFixtures.upcoming.count
        case .basketball: return basketballFixtures.upcoming.count
        case .tennis: return tennisFixtures.upcoming.count
        case .cricket: return cricketFixtures.upcoming.count
        }
    }
    
    private var latestEventsCount: Int {
        switch sportType {
        case .football: return footballFixtures.latest.count
        case .basketball: return basketballFixtures.latest.count
        case .tennis: return tennisFixtures.latest.count
        case .cricket: return cricketFixtures.latest.count
        }
    }
    
    func configureTeamCell(cell: TeamsCell,index: Int) {
        if shouldShowEmptyState(section: 0) {
//            cell.config(msg: "No teams available")
            return
        }
        
        cell.layer.cornerRadius = 16
        cell.layer.backgroundColor = AppColors.darkColor.cgColor.copy(alpha: 0.6)
        
        if sportType == .tennis {
            let player = players[index]
            cell.configPlayerCell(teamName: player.player_name ?? "", teamImg: player.player_logo ?? "")
            cell.teamImg.backgroundColor = .white
        } else {
            let team = teams[index]
            cell.config(teamName: team.team_name ?? "", teamImg: team.team_logo ?? "")
        }
    }
    
    func configureUpcomingEventCell(cell: UpcomingEventsCell, index: Int) {
        cell.layer.cornerRadius = 16
        
        switch sportType {
        case .football:
            let fixture = footballFixtures.upcoming[index]
            cell.config(
                time: fixture.time ?? "",
                date: fixture.date ?? "",
                homeName: fixture.homeTeam ?? "",
                awayName: fixture.awayTeam ?? "",
                awayTeamImg: fixture.awayTeamLogo ?? "",
                homeTeamImg: fixture.homeTeamLogo ?? ""
            )
        case .basketball:
            let fixture = basketballFixtures.upcoming[index]
            cell.config(
                time: fixture.time ?? "",
                date: fixture.date ?? "",
                homeName: fixture.homeTeam ?? "",
                awayName: fixture.awayTeam ?? "",
                awayTeamImg: fixture.awayTeamLogo ?? "",
                homeTeamImg: fixture.homeTeamLogo ?? ""
            )
        case .tennis:
            let fixture = tennisFixtures.upcoming[index]
            cell.config(
                time: fixture.time ?? "",
                date: fixture.date ?? "",
                homeName: fixture.firstPlayer ?? "",
                awayName: fixture.secondPlayer ?? "",
                awayTeamImg: fixture.secondPlayerLogo ?? "",
                homeTeamImg: fixture.firstPlayerLogo ?? ""
            )
        case .cricket:
            let fixture = cricketFixtures.upcoming[index]
            cell.config(
                time: fixture.time ?? "",
                date: fixture.dateStart ?? "",
                homeName: fixture.homeTeam ?? "",
                awayName: fixture.awayTeam ?? "",
                awayTeamImg: fixture.awayTeamLogo ?? "",
                homeTeamImg: fixture.homeTeamLogo ?? ""
            )
        }
    }
    
    func configureLatestEventCell(cell: LatestEventsCell, index: Int) {
        switch sportType {
        case .football:
            let fixture = footballFixtures.latest[index]
            cell.config(
                homeTeamName: fixture.homeTeam ?? "",
                awayTeamName: fixture.awayTeam ?? "",
                homeTeamImg: fixture.homeTeamLogo ?? "",
                awayTeamImg: fixture.awayTeamLogo ?? "",
                score: fixture.finalResult ?? "",
                time: fixture.time ?? "",
                date: fixture.date ?? ""
            )
        case .basketball:
            let fixture = basketballFixtures.latest[index]
            cell.config(
                homeTeamName: fixture.homeTeam ?? "",
                awayTeamName: fixture.awayTeam ?? "",
                homeTeamImg: fixture.homeTeamLogo ?? "",
                awayTeamImg: fixture.awayTeamLogo ?? "",
                score: fixture.finalResult ?? "",
                time: fixture.time ?? "",
                date: fixture.date ?? ""
            )
        case .tennis:
            let fixture = tennisFixtures.latest[index]
            cell.config(
                homeTeamName: fixture.firstPlayer ?? "",
                awayTeamName: fixture.secondPlayer ?? "",
                homeTeamImg: fixture.firstPlayerLogo ?? "",
                awayTeamImg: fixture.secondPlayerLogo ?? "",
                score: fixture.finalResult ?? "",
                time: fixture.time ?? "",
                date: fixture.date ?? ""
            )
        case .cricket:
            let fixture = cricketFixtures.latest[index]
            cell.config(
                homeTeamName: fixture.homeTeam ?? "",
                awayTeamName: fixture.awayTeam ?? "",
                homeTeamImg: fixture.homeTeamLogo ?? "",
                awayTeamImg: fixture.awayTeamLogo ?? "",
                score: fixture.status ?? "",
                time: fixture.time ?? "",
                date: fixture.dateStart ?? ""
            )
        }
    }
    
    func shouldShowEmptyState(section: Int) -> Bool {
        switch section {
        case 0: return sportType == .tennis ? players.isEmpty : teams.isEmpty
        case 1: return upcomingEventsCount == 0
        case 2: return latestEventsCount == 0
        default: return true
        }
    }
    
    func getSectionTitle(section: Int) -> String {
        switch section {
        case 0: return "Teams"
        case 1: return "Upcoming Events"
        case 2: return "Latest Events"
        default: return ""
        }
    }
    
    func upcomingListCount()->Int{
        switch sportType {
        case .football:
            return footballFixtures.upcoming.count
        case .basketball:
            return basketballFixtures.upcoming.count
        case .tennis:
            return tennisFixtures.upcoming.count
        default:
            return cricketFixtures.upcoming.count
        }
    }
    
    
    
}
