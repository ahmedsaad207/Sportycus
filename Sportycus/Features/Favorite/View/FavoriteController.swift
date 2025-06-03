import UIKit

protocol FavoriteViewProtocol {
    func renderToView(data: [FavoriteLeague])
}

class FavoriteController: UICollectionViewController, UICollectionViewDelegateFlowLayout, FavoriteViewProtocol {
    
    
    var presenter: FavoritePresenterProtocol!
    var leagues: [FavoriteLeague] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorites Leagues"
        presenter = FavoritePresenter(vc: self)
        registerNibs()
        presenter.getLeagues()
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    func renderToView(data: [FavoriteLeague]) {
        leagues = data
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func registerNibs() {
        let nib = UINib(nibName: "LeagueCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "LeagueCell")
        
        let nibEmpty = UINib(nibName: "EmptyCollectionViewCell", bundle: nil)
        collectionView.register(nibEmpty, forCellWithReuseIdentifier: "EmptyCollectionViewCell")
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if leagues.isEmpty {return 1} else {return leagues.count}
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if leagues.isEmpty {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyCollectionViewCell", for: indexPath) as! EmptyCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCell", for: indexPath) as! LeagueCell
        let league = leagues[indexPath.row]
        cell.leagueName.text = league.leagueName
        cell.leagueCountry.text = league.leagueCountry
        
        let placeholder = UIImage(systemName: "trophy.fill")?.withRenderingMode(.alwaysTemplate)
        cell.leagueLogo.tintColor = .gray
        cell.leagueLogo.kf.setImage(with: URL(string: league.leagueLogo ?? ""), placeholder: placeholder)
        return cell
    }

        override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat!
        height = leagues.isEmpty ? view.safeAreaLayoutGuide.layoutFrame.height : 96
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state != .began { return }

        let point = gesture.location(in: collectionView)

        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }

        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.presenter.deleteLeague(key: Int(self.leagues[indexPath.row].leagueKey))
            self.leagues.remove(at: indexPath.row)
            self.collectionView.reloadData()
        }))
        present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getLeagues()
        collectionView.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if leagues.isEmpty {return}
        let league = leagues[indexPath.row]
        let storyBoardLeagueDetails = UIStoryboard(name: "LeagueDetails", bundle: nil)
        let leagueDetailsVC = storyBoardLeagueDetails.instantiateViewController(withIdentifier: "LeagueDetails") as! LeagueDetailsController
        leagueDetailsVC.presenter = LeagueDetailsPresenter(view: leagueDetailsVC, sportType: SportType(rawValue: league.sportType!)!, league: mapFavoriteLeagueToLeague(league))
        navigationController?.pushViewController(leagueDetailsVC, animated: true)
    }

}
