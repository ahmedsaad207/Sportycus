//
//  LatestEventsCell.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import UIKit
import Kingfisher

class LatestEventsCell: UICollectionViewCell {
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamImg: UIImageView!
    @IBOutlet weak var awayTeamImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    func config(homeTeamName: String, awayTeamName:String, homeTeamImg:String, awayTeamImg:String, score:String, time:String, date:String){
        self.homeTeamName.text = homeTeamName
        self.awayTeamName.text = awayTeamName
        self.score.text = score
        self.time.text = time
        self.date.text = date
        self.homeTeamImg.contentMode = .scaleAspectFit
        self.awayTeamImg.contentMode = .scaleAspectFit
        
//        self.homeTeamImg.layer.cornerRadius = 22
//        self.awayTeamImg.layer.cornerRadius = 22
//        self.homeTeamImg.clipsToBounds = true
//        self.awayTeamImg.clipsToBounds = true
        
        if let homeUrl = URL(string: homeTeamImg) {
            KingfisherManager.shared.retrieveImage(with: homeUrl) { result in
                switch result {
                case .success(let value):
//                    if let trimmed = value.image.trimmedTransparentPixels() {
                        self.homeTeamImg.image = value.image
//                    }
                case .failure:
                    self.homeTeamImg.image = UIImage(systemName: "photo")
                }
            }
        }

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
    }


}

