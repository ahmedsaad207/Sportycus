//
//  LeagueDetailsController.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import UIKit


protocol LeagueDetailsViewProtocol {
    func displayTeams(teams: [Team])
    func displayPlayers(players: [Player])
    func displayFootballFixtures(upcoming: [FootballFixture], latest: [FootballFixture])
    func displayBasketballFixtures(upcoming: [BasketballFixture], latest: [BasketballFixture])
    func displayTennisFixtures(upcoming: [TennisFixture], latest: [TennisFixture])
    func displayCricketFixtures(upcoming: [CricketFixture], latest: [CricketFixture])
    func updateFavoriteStatus(isFavorite: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showError(message: String)
    func setNavigationTitle(title: String)
    func presentAlert(alert: UIAlertController)
}
class LeagueDetailsController: UICollectionViewController, LeagueDetailsViewProtocol {
    
    var presenter: LeagueDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.fetchLeagueDetails()
    }
    
    func setupUI() {
        setBackgroundImage()
        setLayout()
        presenter.setupAppbar()
        registerNibs()
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
    
    private func setLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            
            switch sectionIndex {
            case 0: return self.teamSection()
            case 1: return self.upcomingSection()
            case 2: return self.latestSection()
            default: return nil
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func displayTeams(teams: [Team]) {
        collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func displayPlayers(players: [Player]) {
        collectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func displayFootballFixtures(upcoming: [FootballFixture], latest: [FootballFixture]) {
        collectionView.reloadData()
    }
    
    func displayBasketballFixtures(upcoming: [BasketballFixture], latest: [BasketballFixture]) {
        collectionView.reloadData()
    }
    
    func displayTennisFixtures(upcoming: [TennisFixture], latest: [TennisFixture]) {
        collectionView.reloadData()
    }
    
    func displayCricketFixtures(upcoming: [CricketFixture], latest: [CricketFixture]) {
        collectionView.reloadData()
    }
    
    func updateFavoriteStatus(isFavorite: Bool) {
        let systemImage = isFavorite ? "heart.fill" : "heart"
        let heartButton = UIBarButtonItem(
            image: UIImage(systemName: systemImage),
            style: .plain,
            target: self,
            action: #selector(heartButtonTapped)
        )
        heartButton.tintColor = .green
        navigationItem.rightBarButtonItem = heartButton
    }
    
    func showLoadingIndicator() {
        // Show loading indicator
    }
    
    func hideLoadingIndicator() {
        // Hide loading indicator
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func setNavigationTitle(title: String) {
        navigationItem.title = title
    }
    
    private func teamSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(170), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 0)
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
    
    private func upcomingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(230), heightDimension: .absolute(self.presenter.upcomingListCount() == 0 ? 150 : 400))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 0)
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
    
    private func latestSection() -> NSCollectionLayoutSection {
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
    
    private func registerNibs() {
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
    
    @objc private func heartButtonTapped() {
        presenter.didTapFavoriteButton()
    }
    
    func presentAlert(alert: UIAlertController){
        present(alert, animated: true)
    }
    
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems(section: section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if presenter.shouldShowEmptyState(section: 0) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.emptyCell.rawValue, for: indexPath) as! EmptyCollectionViewCell
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.teamCell.rawValue, for: indexPath) as! TeamsCell
            presenter.configureTeamCell(cell: cell, index: indexPath.item)
            return cell
            
        case 1:
            if presenter.shouldShowEmptyState(section: 1) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.emptyCell.rawValue, for: indexPath) as! EmptyCollectionViewCell
                cell.config(msg: "No upcoming events.")
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.upcomingEventCell.rawValue, for: indexPath) as! UpcomingEventsCell
            presenter.configureUpcomingEventCell(cell: cell, index: indexPath.item)
            return cell
            
        case 2:
            if presenter.shouldShowEmptyState(section: 2) {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.emptyCell.rawValue, for: indexPath) as! EmptyCollectionViewCell
                cell.config(msg: "No latest events.")
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID.latestEventCell.rawValue, for: indexPath) as! LatestEventsCell
            presenter.configureLatestEventCell(cell: cell, index: indexPath.item)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CellID.sectionHeader.rawValue,
                for: indexPath
            ) as! HeaderCollectionReusableView

            header.headerLabel.textColor = .white
            header.headerLabel.text = presenter.getSectionTitle(section: indexPath.section)
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && !presenter.shouldShowEmptyState(section: 0) {
            presenter.didSelectTeam(index: indexPath.item, navigationController: self.navigationController!)
        }
    }
}
