//
//  ViewController.swift
//  layerAnimations
//
//  Created by Dariel on 16/6/21.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

// 延迟执行
func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let circleLayer = CAShapeLayer()
        let maskLayer = CAShapeLayer()
        
        circleLayer.path = UIBezierPath(ovalInRect: dogImageView.bounds).CGPath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        maskLayer.path = circleLayer.path
        // 超出maskLayer部分裁剪掉
        dogImageView.layer.mask = maskLayer
        dogImageView.layer.addSublayer(circleLayer)
     
        
        
//        dogImageView.layer.cornerRadius = dogImageView.frame.width/2
//        dogImageView.layer.masksToBounds = true
        
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        keyframeAnimations()
    }    
    
    func keyframeAnimations() {
    
        // 如果要同时设置几个值,该怎样实现
        let wobble = CAKeyframeAnimation(keyPath: "transform.rotation")
        wobble.duration = 2.5
        wobble.repeatCount = MAXFLOAT
        // 会依次遍历数组中每一个值
        wobble.values = [0.0, -M_PI_4/4, 0.0, M_PI_4/4, 0.0]
        // 为values中的值设置时间,keyTimes按照百分比来的,[0,1]之间
        wobble.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        dogImageView.layer.addAnimation(wobble, forKey: nil)
        
//        // fromValue可以接受结构体
//        let move = CABasicAnimation(keyPath: "position")
//        move.duration = 2.5
//        // 注意:不能将CGPoint直接赋值给fromValue,toValue需要转换
//        move.fromValue = NSValue(CGPoint: CGPoint(x:100, y:100))
//        move.toValue = NSValue(CGPoint: CGPoint(x:200, y:200))
//        dogImageView.layer.addAnimation(move, forKey: nil)
        
        
//        let flight = CAKeyframeAnimation(keyPath: "position")
//        flight.duration = 2.0
//        // 无限重复
//        flight.repeatCount = MAXFLOAT
//        
//        // .map { NSValue(CGPoint: $0)}可以将数组中的每一个CGPoint转化为NSValue
//        flight.values = [
//            CGPoint(x: 50.0, y: 100.0),
//            CGPoint(x: view.frame.width-50, y: 160),
//            CGPoint(x: 50.0, y: view.center.y),
//            CGPoint(x: 50.0, y: 100.0)
//            ].map { NSValue(CGPoint: $0)}
//        
//        
////        flight.values = [
////            NSValue(CGPoint: CGPoint(x: 50.0, y: 100.0)),
////            NSValue(CGPoint: CGPoint(x: view.frame.width-50, y: 160)),
////            NSValue(CGPoint: CGPoint(x: 50.0, y: view.center.y)),
////            NSValue(CGPoint: CGPoint(x: 50.0, y: 100.0)),
////            ]
//        
//        flight.keyTimes = [0.0, 0.33, 0.66, 1.0]
//        dogImageView.layer.addAnimation(flight, forKey: nil)
    }
    
    lazy var dogImageView: UIImageView = {
        
        let dogImageView = UIImageView(image: UIImage(named: "Snip20160615_3"))
        dogImageView.sizeToFit()
        dogImageView.center.y = self.view.center.y
        dogImageView.layer.cornerRadius = 4
        dogImageView.layer.position.x = 100
        self.view.addSubview(dogImageView)
        return dogImageView
    }()
}

