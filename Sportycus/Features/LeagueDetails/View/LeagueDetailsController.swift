//
//  LeagueDetailsController.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import UIKit


protocol LeagueDetailsViewProtocol{
    func displayData<T>(data: ([T],[T]))
    func onLeagueCheckedIfCached(cached: Bool)
    func getCurrentLeague(league: League)
    func displayTeam(team: [Team])
}

class LeagueDetailsController: UICollectionViewController , LeagueDetailsViewProtocol {

    
    var teamList: [Team]?
    var footballFixtures: ([FootballFixture],[FootballFixture]) = ([],[])
    var basketballFixtures: ([BasketballFixture] ,[BasketballFixture]) = ([],[])
    var tennisFixtures: ([TennisFixture],[TennisFixture]) = ([],[])
    var cricketFixtures: ([CricketFixture],[CricketFixture]) = ([],[])

    var currentLeague: League!
    
    func getCurrentLeague(league: League) {
        currentLeague = league
    }
    
    func displayData<T>(data: ([T],[T])) {
        if let fixtures = data as? ([FootballFixture],[FootballFixture]) {
            self.footballFixtures = fixtures
        } else if let fixtures = data as? ([BasketballFixture] ,[BasketballFixture]) {
            self.basketballFixtures = fixtures
        } else if let fixtures = data as? ([TennisFixture],[TennisFixture]) {
            self.tennisFixtures = fixtures
        } else if let fixtures = data as? ([CricketFixture],[CricketFixture]) {
            self.cricketFixtures = fixtures
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func displayTeam(team: [Team]) {
        self.teamList = team
        DispatchQueue.main.async{
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    func onLeagueCheckedIfCached(cached: Bool) {
          isFavorite = cached
          setupAppBar()
      }

    
    var isFavorite: Bool!

    var presenter: LeagueDetailsPresenterProtocol!
    
    func setupAppBar(){
        self.navigationItem.title = self.currentLeague.league_name
        
            let systemImage =  isFavorite ? "heart.fill" : "heart"

                let heartButton = UIBarButtonItem(
                    image: UIImage(systemName: systemImage),
                    style: .plain,
                    target: self,
                    action: #selector(heartButtonTapped)
                )
                navigationItem.rightBarButtonItem = heartButton
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        registerNibs()
        presenter.getLeagueDetails()
        presenter.isLeagueExist(leagueKey: currentLeague.league_key!)

    }
    
    func setLayout(){
        let layout = UICollectionViewCompositionalLayout { sectionIndex, enviroment in

            switch sectionIndex {
                    case 0 :
                        return self.teamSection()
                    case 1 :
                        return self.upcomingSection()
                    default:
                        return self.latestSection()
                    }
                }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func teamSection () -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(170), heightDimension: .absolute(170))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
       , subitems: [item])
           group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
           , bottom: 0, trailing: 16)
           
       let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16
           , bottom: 10, trailing: 0)
           section.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .leading
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func upcomingSection () -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(225))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
       , subitems: [item])
           group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
           , bottom: 0, trailing: 15)
           
       let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
           , bottom: 10, trailing: 0)
           section.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .leading
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func latestSection () -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(225))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
       , subitems: [item])
           group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom:16, trailing: 0)
           
       let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16
           , bottom: 0, trailing: 16)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .leading
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CellID.sectionHeader.rawValue,
                for: indexPath
            ) as! HeaderCollectionReusableView

            switch indexPath.section {
            case 0:
                header.headerLabel.text = "Teams"
            case 1:
                header.headerLabel.text = "Upcoming Events"
            default:
                header.headerLabel.text = "Latest Events"
            }
            return header
        }
        return UICollectionReusableView()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch section {
        case 0:
            return self.teamList?.count ?? 0
        case 1:
            return self.getSectionCountBasedOnSport(sportType: self.presenter.getSportType()).1
        default:
            return self.getSectionCountBasedOnSport(sportType: self.presenter.getSportType()).0
        }
    }

    func getSectionCountBasedOnSport(sportType: SportType) -> (Int, Int){
        switch sportType {
        case .football:
            return (footballFixtures.0.count, footballFixtures.1.count)
        case .basketball:
            return (basketballFixtures.0.count,basketballFixtures.1.count)
        case .tennis:
            return (tennisFixtures.0.count, tennisFixtures.1.count)
        case .cricket:
            return (cricketFixtures.0.count, cricketFixtures.1.count)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellID.teamCell.rawValue,
                for: indexPath
            ) as! TeamsCell
            
            let team = teamList?[indexPath.row]
            cell.config(teamName: team?.team_name ?? "", teamImg: team?.team_logo ?? "")
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellID.upcomingEventCell.rawValue,
                for: indexPath
            ) as! UpcomingEventsCell

            switch presenter?.getSportType() {
            case .football:
                let fixture = footballFixtures.1[indexPath.item]
                cell.config(
                    time: fixture.time ?? "",
                    date: fixture.date ?? "",
                    homeName: fixture.homeTeam ?? "",
                    awayName: fixture.awayTeam ?? "",
                    awayTeamImg: fixture.awayTeamLogo ?? "",
                    homeTeamImg: fixture.homeTeamLogo ?? ""
                )

            case .basketball:
                let fixture = basketballFixtures.1[indexPath.item]
                cell.config(
                    time: fixture.time ?? "",
                    date: fixture.date ?? "",
                    homeName: fixture.homeTeam ?? "",
                    awayName: fixture.awayTeam ?? "",
                    awayTeamImg: fixture.awayTeamLogo ?? "",
                    homeTeamImg: fixture.homeTeamLogo ?? ""
                )

            case .tennis:
                let fixture = tennisFixtures.1[indexPath.item]
                cell.config(
                    time: fixture.time ?? "",
                    date: fixture.date ?? "",
                    homeName: fixture.firstPlayer ?? "",
                    awayName: fixture.secondPlayer ?? "",
                    awayTeamImg: fixture.secondPlayerLogo ?? "",
                    homeTeamImg: fixture.firstPlayerLogo ?? ""
                )

            case .cricket:
                let fixture = cricketFixtures.1[indexPath.item]
                cell.config(
                    time: fixture.time ?? "",
                    date: fixture.dateStart ?? "",
                    homeName: fixture.homeTeam ?? "",
                    awayName: fixture.awayTeam ?? "",
                    awayTeamImg: fixture.awayTeamLogo ?? "",
                    homeTeamImg: fixture.homeTeamLogo ?? ""
                )

            default:
                break
            }
            return cell

        default:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellID.latestEventCell.rawValue,
                for: indexPath
            ) as! LatestEventsCell

            switch presenter?.getSportType() {
            case .football:
                let fixture = footballFixtures.0[indexPath.item]
                cell.config(
                    homeTeamName: fixture.homeTeam ?? "",
                    awayTeamName: fixture.awayTeam ?? "",
                    homeTeamImg: fixture.homeTeamLogo ?? "",
                    awayTeamImg: fixture.awayTeamLogo ?? "",
                    score: fixture.finalResult ?? "-",
                    time: fixture.time ?? "",
                    date: fixture.date ?? ""
                )
            case .basketball:
                let fixture = basketballFixtures.0[indexPath.item]
                cell.config(
                    homeTeamName: fixture.homeTeam ?? "",
                    awayTeamName: fixture.awayTeam ?? "",
                    homeTeamImg: fixture.homeTeamLogo ?? "",
                    awayTeamImg: fixture.awayTeamLogo ?? "",
                    score: fixture.finalResult ?? "-",
                    time: fixture.time ?? "",
                    date: fixture.date ?? ""
                )
            case .tennis:
                let fixture = tennisFixtures.0[indexPath.item]
                cell.config(
                    homeTeamName: fixture.firstPlayer ?? "",
                    awayTeamName: fixture.secondPlayer ?? "",
                    homeTeamImg: fixture.firstPlayerLogo ?? "",
                    awayTeamImg: fixture.secondPlayerLogo ?? "",
                    score: fixture.finalResult ?? "-",
                    time: fixture.time ?? "",
                    date: fixture.date ?? ""
                )
            case .cricket:
                let fixture = cricketFixtures.0[indexPath.item]
                cell.config(
                    homeTeamName: fixture.homeTeam ?? "",
                    awayTeamName: fixture.awayTeam ?? "",
                    homeTeamImg: fixture.homeTeamLogo ?? "",
                    awayTeamImg: fixture.awayTeamLogo ?? "",
                    score: fixture.status ?? "",
                    time: fixture.time ?? "",
                    date: fixture.dateStart ?? ""
                )
            default:
                break
            }
            return cell
        }
    }


    func registerNibs(){
        let nibUpcomingEvents = UINib(nibName: CellID.upcomingEventCell.rawValue, bundle: nil)
        let nibLatestEvents = UINib(nibName: CellID.latestEventCell.rawValue, bundle: nil)
        let nibTeams = UINib(nibName: CellID.teamCell.rawValue, bundle: nil)
        collectionView.register(nibUpcomingEvents, forCellWithReuseIdentifier: CellID.upcomingEventCell.rawValue)
        collectionView.register(nibLatestEvents, forCellWithReuseIdentifier: CellID.latestEventCell.rawValue)
        collectionView.register(nibTeams, forCellWithReuseIdentifier: CellID.teamCell.rawValue)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let teamStoryBoard = UIStoryboard(name: "Team", bundle: nil)
            let teamVC = teamStoryBoard.instantiateViewController(identifier: "team") as! TeamController
            teamVC.teamKey = teamList?[indexPath.row].team_key ?? 0
            teamVC.sportName = self.presenter.getSportType().path
            teamVC.leagueId = self.currentLeague.league_key
            self.navigationController?.pushViewController(teamVC, animated: true)
        }
    }


        @objc func heartButtonTapped() {
            if isFavorite {
                showDeleteAlert()
            } else {
                let league = League(league_key: self.currentLeague.league_key!, league_name: self.currentLeague.league_name!, league_logo: self.currentLeague.league_logo)
                presenter.addLeague(league: league)
                toggle()
            }
        }
        
        func showDeleteAlert() {
            let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.presenter.deleteLeague(key: Int(self.currentLeague.league_key!))
                self.toggle()
            }))
            present(alert, animated: true)
        }
                                                   
        func toggle() {
            let systemImage =  isFavorite ? "heart" : "heart.fill"
            navigationItem.rightBarButtonItem!.image = UIImage(systemName: systemImage)
            isFavorite.toggle()
        }
}


