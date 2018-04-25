//
//  ViewController.swift
//  ReplicatingAnimations
//
//  Created by Dariel on 16/6/26.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.darkGrayColor()

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dotAnim()
    }
    
    
    
    func dotAnim() {
        
        
        let replicator = CAReplicatorLayer()
        let dot = CALayer()
        
        let dotLength : CGFloat = 6.0
        let dotOffset : CGFloat = 8.0
        
        replicator.frame = view.bounds
        view.layer.addSublayer(replicator)
        
        dot.frame = CGRect(x: replicator.frame.size.width - dotLength, y: replicator.position.y, width: dotLength, height: dotLength)
        dot.backgroundColor = UIColor.lightGrayColor().CGColor
        dot.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        dot.borderWidth = 0.5
        dot.cornerRadius = 1.5
        replicator.addSublayer(dot)
        
        // 进行复制
        replicator.instanceCount = Int(view.frame.size.width / dotOffset)
        replicator.instanceTransform = CATransform3DMakeTranslation(-dotOffset, 0.0, 0.0)
        
//        let move = CABasicAnimation(keyPath: "position.y")
//        move.fromValue = dot.position.y
//        move.toValue = dot.position.y - 50.0
//        move.duration = 1.0
//        move.repeatCount = 10
//        dot.addAnimation(move, forKey: nil)

        replicator.instanceDelay = 0.02


        let scale = CABasicAnimation(keyPath: "transform")
        scale.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        scale.toValue = NSValue(CATransform3D: CATransform3DMakeScale(1.4, 15, 1.0))
        scale.duration = 0.33
        scale.repeatCount = Float.infinity
        scale.autoreverses = true
        scale.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        dot.addAnimation(scale, forKey: "dotScale")

        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 1.0
        fade.toValue = 0.2
        fade.duration = 0.33
        fade.beginTime = CACurrentMediaTime() + 0.33
        fade.repeatCount = Float.infinity
        fade.autoreverses = true
        fade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        dot.addAnimation(fade, forKey: "dotOpacity")

        
        let tint = CABasicAnimation(keyPath: "backgroundColor")
        tint.fromValue = UIColor.magentaColor().CGColor
        tint.toValue = UIColor.cyanColor().CGColor
        tint.duration = 0.66
        tint.beginTime = CACurrentMediaTime() + 0.28
        tint.fillMode = kCAFillModeBackwards
        tint.repeatCount = Float.infinity
        tint.autoreverses = true
        tint.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        dot.addAnimation(tint, forKey: "dotColor")

        
        
        let initialRotation = CABasicAnimation(keyPath: "instanceTransform.rotation")
        initialRotation.fromValue = 0.0
        initialRotation.toValue = 0.01
        initialRotation.duration = 0.33
        initialRotation.removedOnCompletion = false
        initialRotation.fillMode = kCAFillModeForwards
        initialRotation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        replicator.addAnimation(initialRotation, forKey: "initialRotation")

        let rotation = CABasicAnimation(keyPath: "instanceTransform.rotation")
        rotation.fromValue = 0.01
        rotation.toValue = -0.01
        rotation.duration = 0.99
        rotation.beginTime = CACurrentMediaTime() + 0.33
        rotation.repeatCount = Float.infinity
        rotation.autoreverses = true
        rotation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        replicator.addAnimation(rotation, forKey: "replicatorRotation")

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

