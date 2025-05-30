//
//  Navigate.swift
//  L11T1
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation
import UIKit

class Navigate {
    
    private init(){}
    
    static func pushWithNoArgs(to viewControllerID: StoryboardID, navController: UINavigationController) {
        let storyboard = UIStoryboard(name: viewControllerID.name, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: viewControllerID.identifier)
        navController.pushViewController(vc, animated: true)
    }

}
