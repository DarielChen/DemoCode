//
//  RWLogoLayer.swift
//  reveal
//
//  Created by Dariel on 16/7/26.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class RWLogoLayer {

    class func logoLayer() -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.geometryFlipped = true
        
        //the RW bezier
        let bezier = UIBezierPath()
        bezier.moveToPoint(CGPoint(x: 0.0, y: 0.0))
        bezier.addCurveToPoint(CGPoint(x: 0.0, y: 66.97), controlPoint1:CGPoint(x: 0.0, y: 0.0), controlPoint2:CGPoint(x: 0.0, y: 57.06))
        bezier.addCurveToPoint(CGPoint(x: 16.0, y: 39.0), controlPoint1: CGPoint(x: 27.68, y: 66.97), controlPoint2:CGPoint(x: 42.35, y: 52.75))
        bezier.addCurveToPoint(CGPoint(x: 26.0, y: 17.0), controlPoint1: CGPoint(x: 17.35, y: 35.41), controlPoint2:CGPoint(x: 26, y: 17))
        bezier.addLineToPoint(CGPoint(x: 38.0, y: 34.0))
        bezier.addLineToPoint(CGPoint(x: 49.0, y: 17.0))
        bezier.addLineToPoint(CGPoint(x: 67.0, y: 51.27))
        bezier.addLineToPoint(CGPoint(x: 67.0, y: 0.0))
        bezier.addLineToPoint(CGPoint(x: 0.0, y: 0.0))
        bezier.closePath()
        
        //create a shape layer
        layer.path = bezier.CGPath
        layer.bounds = CGPathGetBoundingBox(layer.path)
        
        return layer
    }
}
