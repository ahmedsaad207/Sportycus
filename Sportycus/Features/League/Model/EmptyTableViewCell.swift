import UIKit

class EmptyTableViewCell: UITableViewCell {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(_ message: String) {
        playerLabel.text = message
    }

    
}
