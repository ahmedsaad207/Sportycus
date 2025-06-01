//
//  TeamsCell.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import UIKit

class TeamsCell: UICollectionViewCell {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func config(teamName: String, teamImg:String){
        self.teamName.text = teamName
        self.teamImg.kf.setImage(with: URL(string: teamImg), placeholder: UIImage(systemName: "photo"))
    }

}
