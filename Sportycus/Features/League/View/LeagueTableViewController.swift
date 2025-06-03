import UIKit
import Kingfisher

protocol LeagueViewProtocol {
    func renderToView(data: [League])
}

class LeagueTableViewController: UITableViewController, LeagueViewProtocol {

    var presenter: LeaguePresenterProtocol!
    var networkIndicator: UIActivityIndicatorView!

    func registerNibs(){
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell")
    }
    
    func setupAppbar(){
        self.navigationItem.title = presenter.getSportType().rawValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        setupAppbar()
        presenter.getLeagues()
        
        networkIndicator = UIActivityIndicatorView()
        networkIndicator.center = view.center
        view.addSubview(networkIndicator)
        networkIndicator.startAnimating()
       
        
    }
    
    func renderToView(data: [League]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.networkIndicator.stopAnimating()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getLeaguesCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell
        let league = presenter.league(at: indexPath.row)
        let placeholder = UIImage(systemName: "trophy.fill")?.withRenderingMode(.alwaysTemplate)
        cell.leagueLogo.tintColor = .gray
        
        cell.leagueName.text = league.league_name
        cell.leagueLogo.kf.setImage(with: URL(string: league.league_logo ?? ""), placeholder: placeholder)
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let league = presenter.league(at: indexPath.row)
        let storyBoardLeagueDetails = UIStoryboard(name: "LeagueDetails", bundle: nil)
        let leagueDetailsVC = storyBoardLeagueDetails.instantiateViewController(withIdentifier: "LeagueDetails") as! LeagueDetailsController
        leagueDetailsVC.presenter = LeagueDetailsPresenter(view: leagueDetailsVC, sportType: presenter.getSportType(), league: league)
        navigationController?.pushViewController(leagueDetailsVC, animated: true)
    }
}
