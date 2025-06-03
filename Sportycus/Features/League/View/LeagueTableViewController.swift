
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
        
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0) // for vertical space at top/bottom
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 120
        
        registerNibs()
        setTableViewBackground()
        setupAppbar()
        presenter.getLeagues()

        networkIndicator = UIActivityIndicatorView()
        networkIndicator.center = view.center
        view.addSubview(networkIndicator)
        networkIndicator.startAnimating()
    }

    
    private func setTableViewBackground() {
        let backgroundImage = UIImageView(frame: tableView.bounds)
        view.backgroundColor = AppColors.darkColor
//        backgroundImage.image = UIImage(named: "blurbg")
        backgroundImage.contentMode = .scaleAspectFill
        tableView.backgroundView = backgroundImage
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

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let maskLayer = CALayer()
        maskLayer.frame = cell.bounds.insetBy(dx: 12, dy: 8)
        
        maskLayer.backgroundColor = UIColor.white.cgColor
        cell.layer.mask = maskLayer
        
        cell.contentView.layer.cornerRadius = 12
        cell.contentView.layer.masksToBounds = true
        cell.backgroundColor = .clear

        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
    }



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell
        let league = presenter.league(at: indexPath.row)
        
        cell.container.backgroundColor = AppColors.cardColor
        cell.container.layer.cornerRadius = 12
        cell.leagueName.textColor = .white
        cell.leagueName.text = league.league_name
        cell.leagueLogo.kf.setImage(with: URL(string: league.league_logo ?? ""), placeholder: UIImage(systemName: "photo"))
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        cell.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

        // cell.contentView.layer.cornerRadius = 12
        // cell.contentView.layer.masksToBounds = true
        
        
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
