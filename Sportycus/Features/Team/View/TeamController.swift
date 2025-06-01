import UIKit

protocol TeamViewProtocol {
    func renderToView(response: TeamResponse)
}

class TeamController: UITableViewController, TeamViewProtocol {
    var team: Team = Team()
//    var loadingView = LoadingIndicatorView()
    var leagueId: Int!
    var sportName: String!
    var teamKey: Int!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        loadingView.show(in:view)
        
        title = "Team Info"
        
        // register nib cell
        let nibTeam = UINib(nibName: "TeamInfoCell", bundle: nil)
        tableView.register(nibTeam, forCellReuseIdentifier: "teamInfoCell")
        
        let nibPlayer = UINib(nibName: "PlayerCell", bundle: nil)
        tableView.register(nibPlayer, forCellReuseIdentifier: "playerCell")

        TeamPresenter(vc: self).getTeam(sport: sportName,teamKey: teamKey, leagueId: leagueId)
    }
    
    func renderToView(response: TeamResponse) {
        team = response.result[0]
        DispatchQueue.main.async {
            self.tableView.reloadData()
//            self.loadingView.hide()
        }
    }
    
    @objc func onFavoriteButtonClick() {
        print("Favorite clicked!")
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 1
            case 1: return team.coaches?.count ?? 0
            case 2: return team.players?.count ?? 0
            default: return 0
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
        return 96
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamInfoCell", for: indexPath) as! TeamInfoCell
            cell.teamName.text = team.team_name
            cell.teamLogo.kf.setImage(with: URL(string: team.team_logo ?? ""), placeholder: UIImage(systemName: "photo"))
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
        
        
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
                cell.playerImage.kf.setImage(with: URL(string: player.player_image ?? ""), placeholder: UIImage(systemName: "person"))
            default: cell.playerName.text = ""
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
