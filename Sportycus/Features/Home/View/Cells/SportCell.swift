//
//  SportCell.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import UIKit

class SportCell: UICollectionViewCell {

    @IBOutlet weak var sportTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(imgName:String, title:String){
        img.image = UIImage(named: imgName)
        sportTitle.text = title
    }

}
