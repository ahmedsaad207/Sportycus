//
//  LeagueDetailsController.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import UIKit


protocol LeagueDetailsViewProtocol{
    func displayData<T>(data: [T])
}

class LeagueDetailsController: UICollectionViewController , LeagueDetailsViewProtocol {
    
    func displayData<T>(data: [T]) {
        
    }
    
    var isFavorite: Bool!

    var presenter: LeagueDetailsPresenterProtocol!
    
    func setupAppBar(){
        let heartImage = UIImage(systemName: "heart")
            let heartButton = UIBarButtonItem(
                image: heartImage,
                style: .plain,
                target: self,
                action: #selector(heartButtonTapped)
            )
            navigationItem.rightBarButtonItem = heartButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppBar()
        setLayout()
        registerNibs()
        presenter.getLeagueDetails()
        isFavorite = false
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(225))
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
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func upcomingSection () -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(225))
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
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func latestSection () -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(225))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
       , subitems: [item])
           group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
           , bottom: 0, trailing: 15)
           
       let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
           , bottom: 10, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
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
            //teams
            return 5
        case 1:
            //upcoming
            return 5
        default:
            //latest
           return 5
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.teamCell.rawValue, for: indexPath) as! TeamsCell
            cell.config(teamName: "team name", teamImg: "")
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.upcomingEventCell.rawValue, for: indexPath)as! UpcomingEventsCell
            cell.config(time: "time", date: "date", homeName: "home name", awayName: "away name", awayTeamImg: "", homeTeamImg: "")
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.latestEventCell.rawValue, for: indexPath) as! LatestEventsCell
            cell.config(homeTeamName: "home name", awayTeamName: "away name", homeTeamImg: "", awayTeamImg: "", score: "2-2", time: "20:30", date: "05.25.2025")
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
    
    @objc func heartButtonTapped() {
        if isFavorite {
            showDeleteAlert()
        } else {
            presenter.addLeague(league: League())
            toggle()
        }
        
    }
    
    func showDeleteAlert() {
//        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
//            LeagueDetailsPresenter(view: nil).deleteLeague(key: 4)
//            self.toggle()
//        }))
//        present(alert, animated: true)
    }
                                               
    func toggle() {
        let systemImage =  isFavorite ? "heart" : "heart.fill"
        navigationItem.rightBarButtonItem!.image = UIImage(systemName: systemImage)
        isFavorite.toggle()
    }
}


