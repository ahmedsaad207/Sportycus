//
//  TeamsCell.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import UIKit
import Kingfisher
class TeamsCell: UICollectionViewCell {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(teamName: String, teamImg: String) {
        self.teamName.text = teamName
        self.teamImg.contentMode = .scaleAspectFit
//        self.teamImg.layer.cornerRadius = 22
//        self.teamImg.clipsToBounds = true

        let placeholder = UIImage(systemName: "shield.fill")?.withRenderingMode(.alwaysTemplate)
        self.teamImg.tintColor = .gray
        self.teamImg.kf.setImage(with: URL(string: teamImg),placeholder: placeholder)

    }
    
    func configPlayerCell(teamName: String, teamImg: String) {
        self.teamName.text = teamName
        self.teamImg.contentMode = .scaleAspectFit
        self.teamImg.kf.setImage(with: URL(string: teamImg),placeholder: UIImage(named: "player"))

    }


}
