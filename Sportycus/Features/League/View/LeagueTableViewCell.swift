import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var leagueLogo: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var leagueName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leagueLogo.layer.cornerRadius = leagueLogo.frame.width / 2
        leagueLogo.clipsToBounds = true
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
