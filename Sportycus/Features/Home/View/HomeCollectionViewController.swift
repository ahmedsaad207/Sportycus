//
//  HomeCollectionViewController.swift
//  Sportycus
//
//  Created by Ahmed Saad on 29/05/2025.
//

import UIKit

private let sportCellIdentifier = "SportCell"


protocol HomeViewProtocol {
    func navigateToLeague(sport: String)
}


class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomeViewProtocol {
   
    private var presenter: HomePresenterProtocol!

    func setupAppBar(){
        self.navigationItem.title = "Sports"
    }
    
    func registerNibs(){
        let nibSport = UINib(nibName: sportCellIdentifier, bundle: nil)
        collectionView.register(nibSport, forCellWithReuseIdentifier: sportCellIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppBar()
        registerNibs()
        presenter = HomePresenter(view: self)

    }

//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let size = (collectionView.bounds.width)*0.45
//        
//     return CGSize(width: size, height: size)
//    }

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
    
    func navigateToLeague(sport: String) {
        let leaguestoryboard = UIStoryboard(name: StoryboardID.league.name, bundle: nil)
        let leagueVC = leaguestoryboard.instantiateViewController(identifier: StoryboardID.league.identifier) as! LeagueTableViewController
        leagueVC.presenter = LeaguePresenter(vc: leagueVC , sportName: sport)
    }
}
