//
//  AppColors.swift
//  Sportycus
//
//  Created by Youssif Nasser on 03/06/2025.
//

import Foundation
import UIKit

class AppColors {
    static let darkColor = UIColor(hex: "171C25")!
    static let cardColor = UIColor(hex: "2D3547")!


    private init(){}
}


extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        guard hexSanitized.count == 6 else {
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgbValue)

        let r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
