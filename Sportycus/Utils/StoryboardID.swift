//
//  Routs.swift
//  Sportycus
//
//  Created by Youssif Nasser on 30/05/2025.
//

import Foundation

enum StoryboardID: String {
    case home = "Home"
    case details = "Details"
    case league = "League"

    var identifier: String {
        return self.name.lowercased()
    }

    var name: String {
        return self.rawValue
    }
}
