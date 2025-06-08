import UIKit

class TeamInfoCell: UITableViewCell {

    @IBOutlet weak var fieldImg: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config (sportType: SportType){
        switch sportType {
        case .football:
            fieldImg.image = UIImage(named: "footballfield")
        case .basketball:
            fieldImg.image = UIImage(named: "basketballfield")
        case .tennis:
            fieldImg.image = UIImage(named: "tennisfield")
        default:
            fieldImg.image = UIImage(named: "cricketfield")
        }
    }
    
    func bindTeamDetails(team: Team, sportType: SportType) {
        teamName.text = team.team_name
        config(sportType: sportType)
        let placeholder = UIImage(systemName: "shield.fill")?.withRenderingMode(.alwaysTemplate)
        teamLogo.tintColor = .gray
        teamLogo.kf.setImage(with: URL(string: team.team_logo ?? ""), placeholder: placeholder)
    }
    
    
}
