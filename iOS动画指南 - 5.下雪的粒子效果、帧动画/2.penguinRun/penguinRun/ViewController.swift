//
//  ViewController.swift
//  penguinRun
//
//  Created by Dariel on 16/7/23.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 添加走路动画的图片
    var walkFrames = [
        UIImage(named: "walk01.png")!,
        UIImage(named: "walk02.png")!,
        UIImage(named: "walk03.png")!,
        UIImage(named: "walk04.png")!
    ]
    // 添加滑行的图片
    var slideFrames = [
        UIImage(named: "slide01.png")!,
        UIImage(named: "slide02.png")!,
        UIImage(named: "slide01.png")!
    ]
    
    let animationDuration = 1.0
    let penguinWidth: CGFloat = 108.0
    let penguinHeight: CGFloat = 96.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgView)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(slideButton)
        view.addSubview(penguinView)
        
        // 设置好需要走动动画
        loadWalkAnimation()
    }
    
    // 走路的动画
    func loadWalkAnimation() {
        
        // 将需要添加帧动画的图片添加进去
        penguinView.animationImages = walkFrames
        // 设置播放时间
        penguinView.animationDuration = animationDuration / 3
        // 设置重复次数
        penguinView.animationRepeatCount = 3
        
    }
    // 滑行的动画
    func loadSlideAnimation() {
        penguinView.animationImages = slideFrames
        penguinView.animationDuration = animationDuration
        penguinView.animationRepeatCount = 1
    }
    
    // 判断左右 如果不是右边翻转图片
    var isLookingRight: Bool = true {
        didSet {
            let xScale: CGFloat = isLookingRight ? 1 : -1
            penguinView.transform = CGAffineTransformMakeScale(xScale, 1)
            slideButton.transform = penguinView.transform
        }
    }
    
    
    func leftBtnClick() {
        isLookingRight = false
        penguinView.startAnimating()
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .CurveEaseOut, animations: {
            self.penguinView.center.x -= self.penguinWidth
            }, completion: nil)
    }
    
    func rightBtnClick() {
        isLookingRight = true
        penguinView.startAnimating()
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .CurveEaseOut, animations: {
            self.penguinView.center.x += self.penguinWidth
            }, completion: nil)
        
    }
    
    func slideBtnClick() {
        // 设置滑行动画
        loadSlideAnimation()
        
        penguinView.startAnimating()
        
        UIView.animateWithDuration(animationDuration - 0.02, delay: 0.0, options: .CurveEaseOut, animations: {
            self.penguinView.center.x += self.isLookingRight ?
                self.penguinWidth : -self.penguinWidth
            }, completion: {_ in
                self.loadWalkAnimation()
        })

    }
    
    
    // MARK: - 设置UI
    lazy var bgView : UIImageView = {
        let bgView = UIImageView(image:UIImage(named: "bg"))
        bgView.frame = self.view.bounds
        return bgView
    }()
    
    lazy var leftButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "btn-left"), forState: .Normal)
        btn.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height-100, width: 100, height: 100)
        btn.addTarget(self, action: Selector("leftBtnClick"), forControlEvents: .TouchUpInside)
       return btn
    }()
    
    lazy var rightButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "btn-right"), forState: .Normal)
        btn.frame = CGRect(x: 100, y: UIScreen.mainScreen().bounds.height-100, width: 100, height: 100)
        btn.addTarget(self, action: Selector("rightBtnClick"), forControlEvents: .TouchUpInside)

        return btn
    }()
    
    lazy var slideButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "btn-slide"), forState: .Normal)
        btn.frame = CGRect(x: UIScreen.mainScreen().bounds.width-100, y: UIScreen.mainScreen().bounds.height-100, width: 100, height: 100)
        btn.addTarget(self, action: Selector("slideBtnClick"), forControlEvents: .TouchUpInside)
        return btn
    }()
    
    lazy var penguinView : UIImageView = {
        let penguin = UIImageView()
        penguin.image = UIImage(named: "walk01")
        penguin.frame = CGRect(x: 100, y: UIScreen.mainScreen().bounds.height-175, width: self.penguinWidth , height: 96)
        return penguin
    }()
}




