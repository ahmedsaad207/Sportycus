import UIKit

protocol TeamViewProtocol {
    func renderToView(response: TeamResponse)
    func sport(sportType: SportType)
}

class TeamController: UITableViewController, TeamViewProtocol {
    
   
    
    var sportType: SportType!
    var team: Team = Team()
//    var loadingView = LoadingIndicatorView()
    var leagueId: Int!
//    var sportName: String!
    var teamKey: Int!
    
    var presenter: TeamPresenter!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        loadingView.show(in:view)
        setBackgroundImage()
        title = "Team Info"
        
        // register nib cell
        let nibTeam = UINib(nibName: "TeamInfoCell", bundle: nil)
        tableView.register(nibTeam, forCellReuseIdentifier: "teamInfoCell")
        
        let nibPlayer = UINib(nibName: "PlayerCell", bundle: nil)
        tableView.register(nibPlayer, forCellReuseIdentifier: "playerCell")
        
        let nibEmpty = UINib(nibName: "EmptyTableViewCell", bundle: nil)
        tableView.register(nibEmpty, forCellReuseIdentifier: "EmptyTableViewCell")
        self.presenter.getTeam(sport: sportType.path,teamKey: teamKey, leagueId: leagueId)
    }

    func setBackgroundImage() {
        if let backgroundImage = UIImage(named: "blurbg") {
            let backgroundImageView = UIImageView(image: backgroundImage)
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.frame = tableView.bounds
            backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            tableView.backgroundView = backgroundImageView
        }

        tableView.backgroundColor = .clear
    }

    func sport(sportType: SportType) {
        self.sportType = sportType
    }
    
    func renderToView(response: TeamResponse) {
        team = response.result[0]
        DispatchQueue.main.async {
            self.tableView.reloadData()
//            self.loadingView.hide()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 1
            case 1: return team.coaches?.count ?? 1
            case 2: return team.players?.count ?? 1
            default: return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }

        view.tintColor = UIColor(white: 0.1, alpha: 1.0)
        
        header.textLabel?.textColor = .white
        header.contentView.backgroundColor = UIColor(white: 0.1, alpha: 0.8)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1, 2:
            return 40
        default:
            return 0
        }
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 1: return "Coaches"
            case 2: return "Players"
            default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 230
        }
        
        if team.coaches?.count ?? 0 == 0 || team.players?.count ?? 0 == 0{ return 160} else {}
        return 96
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // team information
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamInfoCell", for: indexPath) as! TeamInfoCell
            cell.teamName.text = team.team_name
            cell.config(sportType: sportType)
            let placeholder = UIImage(systemName: "shield.fill")?.withRenderingMode(.alwaysTemplate)
            cell.teamLogo.tintColor = .gray
            cell.teamLogo.kf.setImage(with: URL(string: team.team_logo ?? ""), placeholder: placeholder)
            return cell
        }
        
        let coachesEmpty = team.coaches?.isEmpty ?? true
        let playersEmpty = team.players?.isEmpty ?? true
        
        if (indexPath.section == 1 && coachesEmpty) {
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
                emptyCell.playerLabel.text = "No Coaches Found"
                return emptyCell
        } else if (indexPath.section == 2 && coachesEmpty) {
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
                emptyCell.playerLabel.text = "No Players Found"
                return emptyCell
        }
        
        // data
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
        cell.bg.backgroundColor = AppColors.navyColor.withAlphaComponent(0.6)

        switch indexPath.section {
            case 1:
                let coach = team.coaches![indexPath.row]
                cell.playerName.text = coach.coach_name
                cell.playerPosition.text = "Coach"
                break
            case 2:
                let player = team.players![indexPath.row]
                cell.playerName.text = player.player_name
                cell.playerNumber.text = "#\(player.player_number ?? "0")"
                cell.playerPosition.text = player.player_type
            
                let placeholder = UIImage(named: "player")
                cell.playerImage.kf.setImage(with: URL(string: player.player_image ?? ""), placeholder: placeholder)
            default: cell.playerName.text = ""
        }
        return cell
    }

}
