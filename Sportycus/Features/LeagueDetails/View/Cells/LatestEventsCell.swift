//
//  LatestEventsCell.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import UIKit

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
        self.awayTeamImg.kf.setImage(with: URL(string: awayTeamImg))
        self.homeTeamImg.kf.setImage(with: URL(string: homeTeamImg))
        self.score.text = score
        self.time.text = time
        self.date.text = date
    }

}
