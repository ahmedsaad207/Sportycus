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
    func displayPlayers(players: [Player])
}

class LeagueDetailsController: UICollectionViewController , LeagueDetailsViewProtocol {
    
    var playersList: [Player]?
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
    
    func displayPlayers(players: [Player]) {
        playersList = players
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
            heartButton.tintColor = .green
                navigationItem.rightBarButtonItem = heartButton
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage()
        setLayout()
        registerNibs()
        presenter.getLeagueDetails()
        presenter.isLeagueExist(leagueKey: currentLeague.league_key!)
        
    }
    
    func setBackgroundImage() {
        let backgroundImage = UIImage(named: "bg")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundView = backgroundImageView

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: collectionView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor)
        ])
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
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    func upcomingSection () -> NSCollectionLayoutSection{
        
        let count = self.getSectionCountBasedOnSport(sportType: self.presenter.getSportType()).1
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(230), heightDimension: .absolute( count == 0 ? 170 : 400 ))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
       , subitems: [item])
           group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
           , bottom: 0, trailing: 0)
           
        
       let section = NSCollectionLayoutSection(group: group)
        
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16
           , bottom: 10, trailing: 0)
           section.orthogonalScrollingBehavior = .continuous
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                guard item.representedElementCategory == .cell else { return }

                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2)
                let minScale: CGFloat = 0.87
                let maxScale: CGFloat = 1.05
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }

    

    func latestSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )

        let separatorSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(1)
        )
        let separator = NSCollectionLayoutSupplementaryItem(
            layoutSize: separatorSize,
            elementKind: "separator-element-kind",
            containerAnchor: NSCollectionLayoutAnchor(edges: [.bottom], fractionalOffset: .zero)
        )

        let item = NSCollectionLayoutItem(
            layoutSize: itemSize,
            supplementaryItems: [separator]
        )

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(190)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.contentInsets = .zero

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .zero

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)
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

            header.headerLabel.textColor = .white

            switch indexPath.section {
            case 0:
                header.headerLabel.text = "Teams"
            case 1:
                header.headerLabel.text = "Upcoming Events"
            default:
                header.headerLabel.text = "Latest Events"
            }
            return header
        } else if kind == "separator-element-kind" {
            let separatorView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "separator-id",
                for: indexPath
            )
            separatorView.backgroundColor = .lightGray
            return separatorView
        }

        return UICollectionReusableView()
    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        switch section {
        case 0:
            let count = presenter.getSportType() == .tennis ? self.playersList?.count ?? 0 : self.teamList?.count ?? 0
            return count == 0 ? 1 : count
        case 1:
            let count = self.getSectionCountBasedOnSport(sportType: self.presenter.getSportType()).1
            return count == 0 ? 1 : count
        default:
            let count = self.getSectionCountBasedOnSport(sportType: self.presenter.getSportType()).0
            return count == 0 ? 1 : count
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
            // Check if teams/players are empty
            let isTennis = presenter.getSportType() == .tennis
            let isEmpty = isTennis ? (playersList?.isEmpty ?? true) : (teamList?.isEmpty ?? true)

            if isEmpty {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CellID.emptyCell.rawValue,
                    for: indexPath
                ) as! EmptyCollectionViewCell
                cell.config(msg: "No teams or players available.")
                return cell
            }

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellID.teamCell.rawValue,
                for: indexPath
            ) as! TeamsCell
            cell.layer.cornerRadius = 16
            cell.layer.backgroundColor = AppColors.darkColor.cgColor.copy(alpha: 0.6)
            if isTennis {
                let player = playersList?[indexPath.item]
                cell.configPlayerCell(teamName: player?.player_name ?? "", teamImg: player?.player_logo ?? "")
                cell.teamImg.backgroundColor = .white
            } else {
                let team = teamList?[indexPath.item]
                cell.config(teamName: team?.team_name ?? "", teamImg: team?.team_logo ?? "")
            }
            return cell

        case 1:
            let upcomingCount = getSectionCountBasedOnSport(sportType: presenter.getSportType()).1
            if upcomingCount == 0 {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CellID.emptyCell.rawValue,
                    for: indexPath
                ) as! EmptyCollectionViewCell
                cell.config(msg: "No upcoming events.")
                return cell
            }

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellID.upcomingEventCell.rawValue,
                for: indexPath
            ) as! UpcomingEventsCell
//            cell.layer.backgroundColor = AppColors.navyColor.cgColor.copy(alpha: 1)

            cell.layer.cornerRadius = 16

            switch presenter.getSportType() {
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
            }
            return cell

        default:
            let latestCount = getSectionCountBasedOnSport(sportType: presenter.getSportType()).0
            if latestCount == 0 {
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CellID.emptyCell.rawValue,
                    for: indexPath
                ) as! EmptyCollectionViewCell
                cell.config(msg: "No latest events.")
                return cell
            }

            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellID.latestEventCell.rawValue,
                for: indexPath
            ) as! LatestEventsCell

            switch presenter.getSportType() {
            case .football:
                let fixture = footballFixtures.0[indexPath.item]
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
                let fixture = basketballFixtures.0[indexPath.item]
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
                let fixture = tennisFixtures.0[indexPath.item]
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
            }
            return cell
        }
    }


    func registerNibs(){
        let nibUpcomingEvents = UINib(nibName: CellID.upcomingEventCell.rawValue, bundle: nil)
        let nibLatestEvents = UINib(nibName: CellID.latestEventCell.rawValue, bundle: nil)
        let nibTeams = UINib(nibName: CellID.teamCell.rawValue, bundle: nil)
        let emptyCellsNib = UINib(nibName: "EmptyCollectionViewCell", bundle: nil)
        collectionView.register(nibUpcomingEvents, forCellWithReuseIdentifier: CellID.upcomingEventCell.rawValue)
        collectionView.register(nibLatestEvents, forCellWithReuseIdentifier: CellID.latestEventCell.rawValue)
        collectionView.register(nibTeams, forCellWithReuseIdentifier: CellID.teamCell.rawValue)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: "separator-element-kind", withReuseIdentifier: "separator-id")
        collectionView.register(emptyCellsNib, forCellWithReuseIdentifier: "EmptyCollectionViewCell")
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let teamStoryBoard = UIStoryboard(name: "Team", bundle: nil)
            let teamVC = teamStoryBoard.instantiateViewController(identifier: "team") as! TeamController
            let teamKey = teamList?[indexPath.row].team_key ?? 0
            let leagueId = self.currentLeague.league_key!
            teamVC.presenter = TeamPresenter(vc: teamVC, sportType: presenter.getSportType(), teamKey: teamKey, leagueId: leagueId)
            self.navigationController?.pushViewController(teamVC, animated: true)
        }
    }


        @objc func heartButtonTapped() {
            if isFavorite {
                showDeleteAlert()
            } else {
                let league = League(league_key: self.currentLeague.league_key!, league_name: self.currentLeague.league_name!, league_logo: self.currentLeague.league_logo, country_name: self.currentLeague.country_name)
                
                presenter.addLeague(league: league, sportType: presenter.getSportType().rawValue)
                toggle()
            }
        }
        
        func showDeleteAlert() {
            let alert = UIAlertController(title: "Unfavorite", message: "Are you sure you want to remove from favorites?", preferredStyle: .alert)
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


