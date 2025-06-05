import UIKit

class LeagueCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var leagueLogo: UIImageView!
    @IBOutlet weak var leagueCountry: UILabel!
    @IBOutlet weak var leagueName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ league: FavoriteLeague) {
        container.backgroundColor = AppColors.cardColor
        leagueName.text = league.leagueName
        leagueCountry.text = league.leagueCountry
        leagueName.textColor = .white
        leagueCountry.textColor = .gray
        container.layer.cornerRadius = 16
        let placeholder = UIImage(systemName: "trophy.fill")?.withRenderingMode(.alwaysTemplate)
        leagueLogo.tintColor = .gray
        leagueLogo.kf.setImage(with: URL(string: league.leagueLogo ?? ""), placeholder: placeholder)
    }
}
