//
//  ViewController.swift
//  layer
//
//  Created by Dariel on 16/6/15.
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

    
    let dogImageView = UIImageView(image: UIImage(named: "Snip20160615_3"))
    let info = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dogImageView.sizeToFit()
        dogImageView.center.y = view.center.y
        dogImageView.layer.cornerRadius = 4
        dogImageView.layer.position.x = view.center.x
        view.addSubview(dogImageView)
        dogImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: Selector("dogImageViewTap"))
        dogImageView.addGestureRecognizer(tap)
        
        
        info.frame = CGRect(x: 0, y: dogImageView.frame.origin.y + 200, width: view.frame.size.width, height: 30)
        info.backgroundColor = UIColor.lightGrayColor()
        info.textAlignment = .Center
        info.textColor = UIColor.orangeColor()
        info.text = "This is Label Text"
        view.addSubview(info)
        
        
        
        
        delay(seconds: 3) { () -> () in
//            self.debuging()
//            self.delegate()
//            self.kvc()
//            self.animationKey()
//            self.animationGroup()
            
//            self.fillMode()


        }
        
    }
    
    func dogImageViewTap() {
        print("dogImageViewTap")
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        move()
//        debuging()
        
        // 停止动画
//        dogImageView.layer.removeAnimationForKey("p")
//        info.layer.removeAllAnimations()
        
//        info.layer.removeAnimationForKey("infoappear")
//        dogImageView.layer.removeAllAnimations()
        
//        self.animationGroup()
        
        self.layerSprings()


    }
    
    // 右移动
    func move() {
        let flyRight = CABasicAnimation(keyPath: "position.x")
        flyRight.fromValue = 80
        flyRight.toValue = 230
        flyRight.duration = 0.5
//        flyRight.removedOnCompletion = false
//        flyRight.fillMode = kCAFillModeForwards

        
        // 延迟执行
        flyRight.beginTime = CACurrentMediaTime() + 0.2
        dogImageView.layer.addAnimation(flyRight, forKey: nil)
//        dogImageView.layer.position.x = 230

    }
    
    // fillMode
    // kCAFillModeRemoved 默认样式 动画结束后会回到layer的开始的状态
    // kCAFillModeForwards 动画结束后,layer会保持结束状态
    // kCAFillModeBackwards layer跳到fromValue的值处,然后从fromValue到toValue播放动画,最后回到layer的开始的状态
    // kCAFillModeBoth kCAFillModeForwards和kCAFillModeBackwards的结合,即动画结束后layer保持在结束状态
    func fillMode() {
        
        let flyRight = CABasicAnimation(keyPath: "position.x")
        // 保证fillMode起作用
        flyRight.removedOnCompletion = false
        flyRight.fillMode = kCAFillModeBoth
        flyRight.fromValue = 100
        flyRight.toValue = 230
        flyRight.duration = 0.5
        
        // 延迟执行
        flyRight.beginTime = CACurrentMediaTime() + 1
        dogImageView.layer.addAnimation(flyRight, forKey: nil)
        
    }
    
    // layer动画并不是真实的,如果要变成真实的需要改变其position
    // 图片可以有监听事件
    // 一般动画设计的时候,我们可以把默认值就设置为动画结束的位置
    // 使用场景:视图不需要交互,且动画的开始和结束需要设置特殊的值
    func debuging() {
        
        let flyRight = CABasicAnimation(keyPath: "position.x")
        // 保证动画不被移除掉
//        flyRight.removedOnCompletion = false
        flyRight.fillMode = kCAFillModeBoth
        flyRight.fromValue = 60
        flyRight.toValue = 230
        flyRight.duration = 0.5
        
        // 延迟执行
        flyRight.beginTime = CACurrentMediaTime() + 1
        dogImageView.layer.addAnimation(flyRight, forKey: nil)
        dogImageView.layer.position.x = 230
    }
    
    // 代理
    func delegate() {
        
        let flyRight = CABasicAnimation(keyPath: "position.x")
        flyRight.delegate = self
        // 保证动画不被移除掉
        //        flyRight.removedOnCompletion = false
        flyRight.fillMode = kCAFillModeBoth
        flyRight.fromValue = 60
        flyRight.toValue = 230
        flyRight.duration = 0.5
        
        // 延迟执行
        flyRight.beginTime = CACurrentMediaTime() + 1
        dogImageView.layer.addAnimation(flyRight, forKey: nil)
        dogImageView.layer.position.x = 230
    }
    
    // KVC设置layer的名称
    // 当我们把flyRight添加到多个控件的时候,怎么设置代理区分,用kvc
    func kvc() {
        
        let flyRight = CABasicAnimation(keyPath: "position.x")
        // 保证动画不被移除掉
//        flyRight.removedOnCompletion = false
        flyRight.fillMode = kCAFillModeBoth
        flyRight.fromValue = 80
        flyRight.toValue = 230
        flyRight.duration = 0.5
        flyRight.delegate = self
        
        // 设置名称
        flyRight.setValue("form", forKey: "name")
        flyRight.setValue(dogImageView.layer, forKey: "layer")
        
        // 延迟执行
        flyRight.beginTime = CACurrentMediaTime() + 1
        dogImageView.layer.addAnimation(flyRight, forKey: "p")
        dogImageView.layer.position.x = 230

        
    }
    
    
    // 怎样在动画运行的时候做一些设置
    // 一次运行多个动画,怎样利用key控制运行动画
    func animationKey() {
        
        let flyLeft = CABasicAnimation(keyPath: "position.x")
        flyLeft.fromValue = info.layer.position.x + view.frame.size.width
        flyLeft.toValue = info.layer.position.x
        flyLeft.duration = 5.0
        // key的作用是当动画开始的时候进行控制的
        info.layer.addAnimation(flyLeft, forKey: "infoappear")
        
        // 通过利用removeAnimationForKey停止动画
        let fadeLabelIn = CABasicAnimation(keyPath: "opacity")
        fadeLabelIn.fromValue = 0.2
        fadeLabelIn.toValue = 1.0
        fadeLabelIn.duration = 4.5
        info.layer.addAnimation(fadeLabelIn, forKey: "fadein")
        
        // 所以这可以在一个layer上执行多个独立的动画
        print(info.layer.animationKeys()!)
    
    }
    
    
    // 组
    func animationGroup() {
    
        let groupAnimation = CAAnimationGroup()
        // 延迟1秒
        groupAnimation.beginTime = CACurrentMediaTime() + 1
        // 整个动画持续3秒
        groupAnimation.duration = 3
        
        groupAnimation.removedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeBoth
        
        // 缓慢加速缓慢减速
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        // 重复次数
        groupAnimation.repeatCount = 4.5
        // 来回往返执行
        groupAnimation.autoreverses = true
        // 速度
        groupAnimation.speed = 2.0
        
        let scaleDown = CABasicAnimation(keyPath: "transform.scale")
        scaleDown.fromValue = 1.5
        scaleDown.toValue = 1.0
        
        let roate = CABasicAnimation(keyPath: "transform.rotation")
        roate.fromValue = CGFloat(M_PI_4)

        roate.toValue = 0.0
        
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0.5
        fade.toValue = 1.0
        
        groupAnimation.animations = [scaleDown, roate, fade]
        dogImageView.layer.addAnimation(groupAnimation, forKey: nil)

    }
    
    
    // 弹簧效果
    func layerSprings() {
        
        let scaleDown = CASpringAnimation(keyPath: "transform.scale")
        scaleDown.fromValue = 1.5
        scaleDown.toValue = 1.0
        
        // settlingDuration：结算时间（根据动画参数估算弹簧开始运动到停止的时间，动画设置的时间最好根据此时间来设置）
        scaleDown.duration = scaleDown.settlingDuration
        // mass：质量（影响弹簧的惯性，质量越大，弹簧惯性越大，运动的幅度越大) 默认值为1
        scaleDown.mass = 10.0
        // stiffness：弹性系数（弹性系数越大，弹簧的运动越快）默认值为100
        scaleDown.stiffness = 1500.0
        // damping：阻尼系数（阻尼系数越大，弹簧的停止越快）默认值为10
        scaleDown.damping = 50
        // initialVelocity：初始速率（弹簧动画的初始速度大小，弹簧运动的初始方向与初始速率的正负一致，若初始速率为0，表示忽略该属性）默认值为0
        scaleDown.initialVelocity = 100
        
        dogImageView.layer.addAnimation(scaleDown, forKey: nil)
        
//        dogImageView.layer.borderWidth = 3.0
//        dogImageView.layer.borderColor = UIColor.clearColor().CGColor
//        
//        let flash = CASpringAnimation(keyPath: "borderColor")
//        flash.damping = 7.0
//        flash.stiffness = 200.0
//        flash.fromValue = UIColor(red: 0.96, green: 0.27, blue: 0.0, alpha: 1).CGColor
//        flash.toValue = UIColor.clearColor().CGColor
//        flash.duration = flash.settlingDuration
//        dogImageView.layer.addAnimation(flash, forKey: nil)
    }
    
}


// MARK: - animationDelegate
extension ViewController {
    
    override func animationDidStart(anim: CAAnimation) {
        print("动画开始调用")
        
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("动画结束调用")
        
        if let name = anim.valueForKey("name") as? String {
            if name == "form" {
                
                print("name is form")
                
                // 动画结束后设置一个先放大然后缩小的效果
                let layer = anim.valueForKey("layer") as? CALayer
                anim.setValue(nil, forKey: "layer")
                
                let pulse = CABasicAnimation(keyPath: "transform.scale")
                pulse.fromValue = 1.25
                pulse.toValue = 1.0
                pulse.duration = 3.25
                layer?.addAnimation(pulse, forKey: nil)
                
            }
        }
    }
}



