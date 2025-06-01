import UIKit

protocol FavoriteViewProtocol {
    func renderToView(data: [FavoriteLeague])
}

class FavoriteController: UICollectionViewController, UICollectionViewDelegateFlowLayout, FavoriteViewProtocol {
    
    
    var presenter: FavoritePresenterProtocol!
    var leagues: [FavoriteLeague] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites Leagues"
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
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leagues.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCell", for: indexPath) as! LeagueCell
        let league = leagues[indexPath.row]
        cell.leagueName.text = league.leagueName
        cell.leagueLogo.kf.setImage(with: URL(string: league.leagueLogo ?? ""), placeholder: UIImage(systemName: "photo"))
        return cell
    }

        override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 96)
    }
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state != .began { return }

        let point = gesture.location(in: collectionView)

        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }

        let alert = UIAlertController(title: "Delete", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.presenter.deleteLeague(key: Int(self.leagues[indexPath.row].leagueKey))

        }))
        present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getLeagues()
        collectionView.reloadData()
    }

    
    

}
