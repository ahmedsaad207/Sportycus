//
//  SplashController.swift
//  Sportycus
//
//  Created by Ahmed Saad on 08/06/2025.
//

import UIKit
import Lottie

class SplashController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }
}
