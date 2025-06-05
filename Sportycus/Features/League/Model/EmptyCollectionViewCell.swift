//
//  EmptyCollectionViewCell.swift
//  Sportycus
//
//  Created by Ahmed Saad on 02/06/2025.
//

import UIKit
import Lottie

class EmptyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var animationView: LottieAnimationView!
    override func awakeFromNib() {
        super.awakeFromNib()
         animationView.contentMode = .scaleAspectFit
         animationView.loopMode = .loop
         animationView.animationSpeed = 0.5
         animationView.play()
    }
    
    func config(msg:String){
        self.msg.text = msg
    }

}
