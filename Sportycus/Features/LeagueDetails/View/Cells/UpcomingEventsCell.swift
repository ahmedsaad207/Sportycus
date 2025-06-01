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
    
    func config(time:String, date:String, homeName:String, awayName:String, awayTeamImg:String, homeTeamImg:String){
        self.awayTeamName.text = awayName
        self.homeTeamName.text = homeName
        self.timeLabel.text = time
        self.dateLabel.text = date
        self.awayTeamImg.kf.setImage(with: URL(string: awayTeamImg), placeholder: UIImage(systemName: "photo"))
        self.homeTeamImg.kf.setImage(with: URL(string: homeTeamImg), placeholder: UIImage(systemName: "photo"))
    }

}
