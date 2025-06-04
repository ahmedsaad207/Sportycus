//
//  HomeCollectionViewController.swift
//  Sportycus
//
//  Created by Ahmed Saad on 29/05/2025.
//

import UIKit

private let sportCellIdentifier = "SportCell"


protocol HomeViewProtocol {
    func navigateToLeague(sport: SportType)
}



class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomeViewProtocol {
   
    private var presenter: HomePresenterProtocol!

    func setupAppBar() {
        self.navigationItem.title = "Sports"

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        appearance.backgroundColor = AppColors.darkColor

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    
    func registerNibs(){
        let nibSport = UINib(nibName: sportCellIdentifier, bundle: nil)
        collectionView.register(nibSport, forCellWithReuseIdentifier: sportCellIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewBackground()
        setupAppBar()
        registerNibs()
        presenter = HomePresenter(view: self)
        
        
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    private func setCollectionViewBackground() {
        let backgroundImage = UIImageView(frame: collectionView.bounds)
        backgroundImage.image = UIImage(named: "bg")
        backgroundImage.contentMode = .scaleAspectFill
        collectionView.backgroundView = backgroundImage
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.size.width / 2 - 15, height: 325)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 22, bottom: 0, right: 22)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.sportsCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sportCellIdentifier, for: indexPath) as! SportCell
    
        let sport = presenter.sport(at: indexPath.row)
        cell.config(imgName: sport.sportImage, title: sport.sportTitle)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectSport(at: indexPath.row)
    }
    
    func navigateToLeague(sport: SportType) {
        let leagueStoryboard = UIStoryboard(name: StoryboardID.league.name, bundle: nil)
        let leagueVC = leagueStoryboard.instantiateViewController(identifier: StoryboardID.league.identifier) as! LeagueTableViewController
        leagueVC.presenter = LeaguePresenter(vc: leagueVC, sportType: sport)
        self.navigationController!.pushViewController(leagueVC, animated: true)
    }

}
