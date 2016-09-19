//
//  ViewController.swift
//  EasyAnimationDemo
//
//  Created by DarielChen on 16/9/18.
//  Copyright © 2016年 DarielChen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var chain: EAAnimationFuture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 基本配置
        view.backgroundColor = UIColor.white
        dogImageView.center = CGPoint(x: 50, y: self.view.frame.size.height/4)
        view.addSubview(dogImageView)
        dogImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dogImageViewTap))
        dogImageView.addGestureRecognizer(tap)
        
        
        dogImageView.layer.masksToBounds = true
        dogImageView.layer.borderColor = UIColor(red: 3/255.0, green: 152/255.0, blue: 255/255.0, alpha: 1).cgColor

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        springLayerAnimations()
//        chainAnimations()
//        easyLayerAnimations()
    
    }
    
    lazy var dogImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "dog"))
        view.frame.size = CGSize(width: 71, height: 75)
        return view
    }()
    
    func dogImageViewTap()  {
//        print("dogImageViewTap")
    }
    
    
    // 链条式动画
    func chainAnimations() {
        
        // 相比系统的animateKeyframesWithDuration也简化了不少
        chain = UIView.animateAndChain(withDuration: 1.0, delay: 0.0, options: [], animations: {
            
                    self.dogImageView.center.x += 150.0
            
                }, completion: nil).animate(withDuration: 1.0, animations: {
                
                    self.dogImageView.center.y += 150.0
                
                }).animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
                
                    self.dogImageView.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
                
                }, completion: nil).animate(withDuration: 0.5, animations: {
                    
                    self.dogImageView.center.x -= 150.0
                    
                }).animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: .repeat, animations: {
                    
                    self.dogImageView.center.y -= 150.0
                    self.dogImageView.transform = CGAffineTransform.identity
                    
                }, completion: nil)
        
        // 需要当前执行的部分停止后才能执行停止这个动作
//        delay(seconds: 4.0) { 
//            self.chain.cancelAnimationChain()
//        }
    }
    
    // 弹性动画
    func springLayerAnimations() {
        
        // 在iOS9之前如果想利用核心动画实现弹性效果其实并不是那么容易的,但有一个库RBBAnimation可以实现,在EasyAnimation中,iOS9之前是用的RBBSpringAnimation,iOS9是用的CASpringAnimation
        UIView.animateAndChain(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.0, options: [], animations: {
            
            self.dogImageView.layer.position.x += 180
            self.dogImageView.layer.cornerRadius = 20
            self.dogImageView.layer.borderWidth = 2
            
            self.dogImageView.layer.transform = CATransform3DConcat(
                CATransform3DMakeRotation(CGFloat(-M_PI_2), 0.0, 0.0, 1.0),
                CATransform3DMakeScale(1.33, 1.33, 1.33)
            )
            
            }, completion: nil).animate(withDuration: 2.0, delay: 0.0, options: .repeat, animations: { 
                
                // 回到初始位置,重复执行动画
                self.dogImageView.layer.transform = CATransform3DIdentity
                self.dogImageView.layer.cornerRadius = 0.0
                self.dogImageView.layer.position.x -= 180

                }, completion: nil)
    }
    
    
    // 简化代码的EasyLayerAnimations
    func easyLayerAnimations() {
        
        // 可以做到一步到位
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
            
            // 位置的修改不用EasyAnimation也可以做到
            self.dogImageView.layer.position.x += 180
            
            // 圆角和边框宽度
            self.dogImageView.layer.cornerRadius = 20
            self.dogImageView.layer.borderWidth = 2
            
            // 添加一个3D旋转效果
            var trans3d = CATransform3DIdentity
            trans3d.m34 = -1.0/500.0
            
            let rotationTransform = CATransform3DRotate(trans3d, CGFloat(-M_PI_4), 0.0, 1.0, 0.0)
            let translationTransform = CATransform3DMakeTranslation(-50.0, 0, 0)
            self.dogImageView.layer.transform = CATransform3DConcat(rotationTransform, translationTransform)
            
            }, completion: nil)
    }

}
// 大幅度简化代码,原理:在类扩展中用runtime做的交换方法,所以不用导入库也能实现效果

