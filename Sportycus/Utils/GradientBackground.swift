//
//  GridBackground.swift
//  Sportycus
//
//  Created by Youssif Nasser on 02/06/2025.
//

import UIKit

class GradientBackground: UIView {

        var gridColor: UIColor = .lightGray
        var cellSize: CGFloat = 20

        override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else { return }

            context.setStrokeColor(gridColor.cgColor)
            context.setLineWidth(0.5)

            var x: CGFloat = 0
            while x < rect.width {
                context.move(to: CGPoint(x: x, y: 0))
                context.addLine(to: CGPoint(x: x, y: rect.height))
                x += cellSize
            }

            var y: CGFloat = 0
            while y < rect.height {
                context.move(to: CGPoint(x: 0, y: y))
                context.addLine(to: CGPoint(x: rect.width, y: y))
                y += cellSize
            }

            context.strokePath()
        }
    

}
