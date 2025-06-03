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

        if let url = URL(string: teamImg) {
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let value):
//                    if let trimmed = value.image.trimmedTransparentPixels() {
                        self.teamImg.image = value.image
//                    }
                case .failure:
                    self.teamImg.image = UIImage(systemName: "photo")
                }
            }
        }
    }


}
