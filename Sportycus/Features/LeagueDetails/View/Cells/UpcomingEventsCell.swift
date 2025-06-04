//
//  UpcomingEventsCell.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import UIKit
import Kingfisher

class UpcomingEventsCell: UICollectionViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamImg: UIImageView!
    @IBOutlet weak var awayTeamImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(time: String, date: String, homeName: String, awayName: String, awayTeamImg: String, homeTeamImg: String) {
        self.awayTeamName.text = awayName
        self.homeTeamName.text = homeName
        self.timeLabel.text = time
        self.dateLabel.text = date

        self.awayTeamImg.contentMode = .scaleAspectFit
        self.homeTeamImg.contentMode = .scaleAspectFit
//        self.awayTeamImg.layer.cornerRadius = 22
//        self.homeTeamImg.layer.cornerRadius = 22
//        self.awayTeamImg.clipsToBounds = true
//        self.homeTeamImg.clipsToBounds = true

        if let awayUrl = URL(string: awayTeamImg) {
            KingfisherManager.shared.retrieveImage(with: awayUrl) { result in
                switch result {
                case .success(let value):
//                    if let trimmed = value.image.trimmedTransparentPixels() {
                        self.awayTeamImg.image = value.image
//                    }
                case .failure:
                    self.awayTeamImg.image = UIImage(systemName: "photo")
                }
            }
        }

        if let homeUrl = URL(string: homeTeamImg) {
            KingfisherManager.shared.retrieveImage(with: homeUrl) { result in
                switch result {
                case .success(let value):
//                    if let trimmed = value.image.trimmedTransparentPixels() {
                        self.homeTeamImg.image = value.image
//                    }
                case .failure:
                    self.homeTeamImg.image = UIImage(systemName: "player")
                }
            }
        }
    }


}
