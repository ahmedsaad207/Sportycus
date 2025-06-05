
import UIKit
import Kingfisher

protocol LeagueViewProtocol {
    func renderToView(data: [League])
}

class LeagueTableViewController: UITableViewController, LeagueViewProtocol {
    
    var presenter: LeaguePresenterProtocol!
    var networkIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.getLeagues()
    }
    
    private func setupUI() {
        registerNibs()
        setTableViewBackground()
        setupAppBar()
        
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 120
        
        networkIndicator = UIActivityIndicatorView()
        networkIndicator.center = view.center
        view.addSubview(networkIndicator)
        networkIndicator.startAnimating()
    }
    
    private func registerNibs() {
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell")
    }
    
    private func setupAppBar() {
        self.navigationItem.title = presenter.getSportType().rawValue
    }
    
    private func setTableViewBackground() {
        let backgroundImage = UIImageView(frame: tableView.bounds)
        backgroundImage.contentMode = .scaleAspectFill
        tableView.backgroundView = backgroundImage
        view.backgroundColor = AppColors.darkColor
    }
    
    func renderToView(data: [League]) {
        tableView.reloadData()
        networkIndicator.stopAnimating()
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
        cell.container.backgroundColor = AppColors.cardColor
        cell.container.layer.cornerRadius = 12
        cell.leagueName.textColor = .white
        cell.leagueName.text = league.league_name
        cell.leagueLogo.kf.setImage(with: URL(string: league.league_logo ?? ""), placeholder: placeholder)
        
        let transparentView = UIView()
        transparentView.backgroundColor = .clear
        cell.selectedBackgroundView = transparentView
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let league = presenter.league(at: indexPath.row)
        let storyboard = UIStoryboard(name: "LeagueDetails", bundle: nil)
        let leagueDetailsVC = storyboard.instantiateViewController(withIdentifier: "LeagueDetails") as! LeagueDetailsController
        leagueDetailsVC.presenter = LeagueDetailsPresenter(view: leagueDetailsVC, sportType: presenter.getSportType(), league: league)
        navigationController?.pushViewController(leagueDetailsVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let maskLayer = CALayer()
        maskLayer.frame = cell.bounds.insetBy(dx: 12, dy: 8)
        maskLayer.backgroundColor = UIColor.white.cgColor
        cell.layer.mask = maskLayer
        cell.contentView.layer.cornerRadius = 12
        cell.contentView.layer.masksToBounds = true
        cell.backgroundColor = .clear
    }
}
