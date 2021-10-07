//
//  Ext+UIVIew.swift
//  Comiditas
//
//  Created by Pedro Sousa on 21/09/21.
//
// swiftlint:disable function_parameter_count

import UIKit

extension UIView {
    func drawDashedLine(from startPoint: CGPoint, to endPoint: CGPoint, color: UIColor,
                        strokeLength: NSNumber, gapLength: NSNumber, width: CGFloat) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = [strokeLength, gapLength]

        let path = CGMutablePath()
        path.addLines(between: [startPoint, endPoint])
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
}
