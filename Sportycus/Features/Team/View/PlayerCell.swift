import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindPlayer(_ player: Player) {
        bg.backgroundColor = AppColors.navyColor.withAlphaComponent(0.6)
        playerName.text = player.player_name
        if let number = player.player_number {
            playerNumber.text = number.isEmpty ? "" : "#\(number)"
        }
        playerPosition.text = player.player_type

        let placeholder = UIImage(named: "player")
        playerImage.kf.setImage(with: URL(string: player.player_image ?? ""), placeholder: placeholder)
    }
    
    func bindCoach(_ coach: Coach) {
        bg.backgroundColor = AppColors.navyColor.withAlphaComponent(0.6)
        playerName.text = coach.coach_name
        playerPosition.text = "Coach"
    }
    
}
