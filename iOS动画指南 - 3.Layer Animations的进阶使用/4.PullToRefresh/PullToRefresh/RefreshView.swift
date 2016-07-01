//
//  RefreshView.swift
//  PullToRefresh
//
//  Created by Dariel on 16/6/22.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit


protocol RefreshViewDelegate {
    func refreshViewDidRefresh(refreshView: RefreshView)
}

class RefreshView: UIView, UIScrollViewDelegate {

    var delegate: RefreshViewDelegate?
    var scrollView: UIScrollView?
    var progress: CGFloat = 0.0
    var refreshing:Bool = false
    var isRefreshing = false

    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    let airplaneLayer: CALayer = CALayer()

    
    init(frame: CGRect, scrollView: UIScrollView) {
        super.init(frame: frame)
        
        self.scrollView = scrollView
        backgroundColor = UIColor(red: 0, green: 155/255.0, blue: 226/255.0, alpha: 1)
        
        // 白色的圈
        ovalShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        ovalShapeLayer.fillColor = UIColor.clearColor().CGColor
        ovalShapeLayer.lineWidth = 4.0
        ovalShapeLayer.lineDashPattern = [2, 3]
        let refreshRadius = frame.size.height/2 * 0.8
        ovalShapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: frame.size.width/2 - refreshRadius, y:frame.size.height/2 - refreshRadius , width: 2*refreshRadius, height: 2*refreshRadius)).CGPath
        layer.addSublayer(ovalShapeLayer)
        
        
        // 添加飞机图片
        let airplaneImage = UIImage(named: "airplane")
        airplaneLayer.contents = airplaneImage?.CGImage
        airplaneLayer.bounds = CGRect(x: 0.0, y: 0.0, width: (airplaneImage?.size.width)!, height: airplaneImage!.size.height)
        airplaneLayer.position = CGPoint(x: frame.size.width/2 + frame.size.height/2 * 0.8, y: frame.size.height/2)
        
        layer.addSublayer(airplaneLayer)
        
        airplaneLayer.opacity = 1.0

        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offsetY = CGFloat( max(-(scrollView.contentOffset.y + scrollView.contentInset.top), 0.0))
        self.progress = min(max( offsetY / frame.size.height, 0.0), 1.0)
        
        if !refreshing {
            redrawFromProgress(progress)
        }
    }
    
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !refreshing && self.progress >= 1.0 {
            delegate?.refreshViewDidRefresh(self)
            beginRefreshing()
        
        }
    }
    
    // 开始刷新
    func beginRefreshing() {
        isRefreshing = true
        UIView.animateWithDuration(0.3, animations: {
            var newInsets = self.scrollView!.contentInset
            newInsets.top += self.frame.size.height
            self.scrollView!.contentInset = newInsets
        })
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.fromValue = -0.5
        strokeStartAnimation.toValue = 1.0
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.fromValue = 0.0
        strokeEndAnimation.toValue = 1.0
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1.5
        strokeAnimationGroup.repeatDuration = 5.0
        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
        ovalShapeLayer.addAnimation(strokeAnimationGroup, forKey: nil)
        
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = ovalShapeLayer.path
        flightAnimation.calculationMode = kCAAnimationPaced
        
        let airplaneOrientationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        airplaneOrientationAnimation.fromValue = 0
        airplaneOrientationAnimation.toValue = 2 * M_PI
        
        
        let flightAnimationGroup = CAAnimationGroup()
        flightAnimationGroup.duration = 1.5
        flightAnimationGroup.repeatDuration = 5.0
        flightAnimationGroup.animations = [flightAnimation, airplaneOrientationAnimation]
        airplaneLayer.addAnimation(flightAnimationGroup, forKey: nil)
        
    }
    
    // 结束刷新
    func endRefreshing() {
        isRefreshing = false
        
        UIView.animateWithDuration(0.3, delay:0.0, options: .CurveEaseOut ,animations: {
            var newInsets = self.scrollView!.contentInset
            newInsets.top -= self.frame.size.height
            self.scrollView!.contentInset = newInsets
            }, completion: {_ in
        })
    }
    
    func redrawFromProgress(progress: CGFloat) {
        
        ovalShapeLayer.strokeEnd = progress
        airplaneLayer.opacity = 1
        
        
    }
}
