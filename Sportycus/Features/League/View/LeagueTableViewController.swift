import UIKit
import Kingfisher

class LeagueTableViewController: UITableViewController, LeagueProtocol {
    var sport: String!
    var leagues: [League] = []
    
    var networkIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkIndicator = UIActivityIndicatorView()
        networkIndicator.center = view.center
        view.addSubview(networkIndicator)
        networkIndicator.startAnimating()
       
        let presenter = LeaguePresenter(vc: self)
        presenter.getLeagues(sport: sport)
        
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell")
    }
    
    func renderToView(response: LeagueResponse) {
        self.leagues = response.result
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.networkIndicator.stopAnimating()
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell
        let league = leagues[indexPath.row]
        cell.leagueName.text = league.league_name
        cell.leagueLogo.kf.setImage(with: URL(string: league.league_logo ?? ""), placeholder: UIImage(systemName: "photo"))
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyBoardLeagueDetails = UIStoryboard(name: "LeagueDetails", bundle: nil)
//        let leagueDetailsVC = storyBoardLeagueDetails.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueTableViewController
//        leagueDetailsVC.league = "" // pass for me sport name here
//        navigationController?.pushViewController(leagueDetailsVC, animated: true)
    }
}
