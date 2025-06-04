//
//  EmptyCollectionViewCell.swift
//  Sportycus
//
//  Created by Ahmed Saad on 02/06/2025.
//

import UIKit
import Lottie

class EmptyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var animationView: LottieAnimationView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // 1. Set animation content mode
         
         animationView.contentMode = .scaleAspectFit
         
         // 2. Set animation loop mode
         
         animationView.loopMode = .loop
         
         // 3. Adjust animation speed
         
         animationView.animationSpeed = 0.5
         
         // 4. Play animation
         animationView.play()
    }

}
