import UIKit
import Lottie

class EmptyTableViewCell: UITableViewCell {

    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var animationView: LottieAnimationView!
    override func awakeFromNib() {
        super.awakeFromNib()
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(_ message: String) {
        playerLabel.text = message
    }

    
}
