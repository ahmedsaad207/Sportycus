//
//  LatestEventsCell.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import UIKit
import Kingfisher

class LatestEventsCell: UICollectionViewCell {
    
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamImg: UIImageView!
    @IBOutlet weak var awayTeamImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(homeTeamName: String, awayTeamName: String, homeTeamImg: String, awayTeamImg: String, score: String, time: String, date: String) {
        self.homeTeamName.text = homeTeamName
        self.awayTeamName.text = awayTeamName
        self.time.text = time
        self.date.text = date
        self.homeTeamImg.contentMode = .scaleAspectFit
        self.awayTeamImg.contentMode = .scaleAspectFit

        let scoreComponents = score.components(separatedBy: " - ")
        if scoreComponents.count == 2,
           let home = Int(scoreComponents[0].trimmingCharacters(in: .whitespaces)),
           let away = Int(scoreComponents[1].trimmingCharacters(in: .whitespaces)) {
            
            self.homeScore.text = "\(home)"
            self.awayScore.text = "\(away)"
            
            if home > away {
                wonTeamScore(score: self.homeScore)
                lostTeamScore(score: self.awayScore)
            } else if away > home {
                wonTeamScore(score: self.awayScore)
                lostTeamScore(score: self.homeScore)
            } else {
                drowTeamScore(score: self.homeScore)
                drowTeamScore(score: self.awayScore)
            }
        } else {
            self.homeScore.text = "#"
            self.awayScore.text = "#"
            drowTeamScore(score: self.homeScore)
            drowTeamScore(score: self.awayScore)
        }

        self.homeTeamImg.kf.setImage(with: URL(string: homeTeamImg), placeholder: UIImage(named: "player"))
        self.awayTeamImg.kf.setImage(with: URL(string: awayTeamImg), placeholder: UIImage(named: "player"))

    }

    func wonTeamScore(score: UILabel) {
        score.textColor = .systemGreen
        score.font = UIFont.boldSystemFont(ofSize: 36)
    }

    func lostTeamScore(score: UILabel) {
        score.textColor = .white
        score.font = UIFont.systemFont(ofSize: 30)
    }
    
    func drowTeamScore(score: UILabel) {
        score.textColor = .white
        score.font = UIFont.systemFont(ofSize: 30)
    }

}

