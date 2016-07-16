//
//  ContainerViewController.swift
//  SideMenu
//
//  Created by Dariel on 16/7/10.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
  
    let menuWidth: CGFloat = 80.0
    let animationTime: NSTimeInterval = 0.5
    var isOpening = false
    let defaultColor = UIColor(red: 120/255.0, green: 150/255.0, blue: 156/255.0, alpha: 1)
    
    let sideMenuVC: UIViewController!
    let mainVC: UIViewController!
    
    init(sideMenu: UIViewController, main: UIViewController) {
    
        sideMenuVC = sideMenu
        mainVC = main
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UINavigationBar.appearance().barTintColor = defaultColor
        view.backgroundColor = defaultColor
        
        addChildViewController(mainVC)
        view.addSubview(mainVC.view)
        mainVC.didMoveToParentViewController(self)
        
        addChildViewController(sideMenuVC)
        view.addSubview(sideMenuVC.view)
        sideMenuVC.didMoveToParentViewController(self)
        
        sideMenuVC.view.layer.anchorPoint.x = 1.0
        sideMenuVC.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        
        let panGesture = UIPanGestureRecognizer(target:self, action:Selector("handleGesture:"))
        view.addGestureRecognizer(panGesture)
        
        setToPercent(0.0)
    }
    
    // 修改导航条颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func handleGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(recognizer.view!.superview!)
        
        // (isOpening ? 1.0 : -1.0) isOpening为BOOL值,表示打开或者关闭
        var progress = translation.x / menuWidth * (isOpening ? 1.0 : -1.0)

        // 保证在0~1之间
        progress = min(max(progress, 0), 1.0)
        
        switch recognizer.state {
        case .Began:
            
            let isOpen = mainVC.view.frame.origin.x/menuWidth
            isOpening = isOpen == 1.0 ? false:true
            
            // 为layer的效果添加一个缓存,作用是避免旋转的时候产生锯齿
            sideMenuVC.view.layer.shouldRasterize = true;
            // 设置渲染的范围
            sideMenuVC.view.layer.rasterizationScale = UIScreen.mainScreen().scale
            
        case .Changed:
            
            // 核心代码:调整容器中视图的位置 3D效果 以及透明度 以及左上角按钮的翻转效果
            setToPercent(isOpening ? progress: (1.0 - progress))
            
        case .Ended: fallthrough
        case .Cancelled: fallthrough
        case .Failed:
            // 分页效果
            var targetProgress: CGFloat
            if (isOpening) {
                targetProgress = progress < 0.5 ? 0.0 : 1.0
            }else {
                targetProgress = progress < 0.5 ? 1.0 : 0.0
            }
            
            // 设置failed状态下的sideMenuVC的view的效果
            UIView.animateWithDuration(animationTime, animations: { () -> Void in
                self.setToPercent(targetProgress)
                }, completion: { (_) -> Void in
                // 记得关闭layer的缓存渲染
                self.sideMenuVC.view.layer.shouldRasterize = false
            })
        default: break
        }
    }
    
    func toggleSideMenu() {
    
        let isOpen = floor(mainVC.view.frame.origin.x/menuWidth)
        let targetProgress: CGFloat = isOpen == 1.0 ? 0.0: 1.0
        
        UIView.animateWithDuration(animationTime, animations: {
            self.setToPercent(targetProgress)
            }, completion: { _ in
                self.mainVC.view.layer.shouldRasterize = false
        })
    
    }

    func setToPercent(percent: CGFloat) {
    
        // 调整mainVC.view的位置
        mainVC.view.frame.origin.x = menuWidth * CGFloat(percent)
        // 设置3D效果及透明度
        sideMenuVC.view.layer.transform = menuTransformForPercent(percent)
        sideMenuVC.view.alpha = CGFloat(max(0.2, percent))
        
        // 左上角按钮的翻转设置
        let mainVc = (mainVC as! UINavigationController).viewControllers.first as? MainViewController
        if let menuButton = mainVc?.menuButton {
            menuButton.imageView.layer.transform = buttonTransformForPercent(percent)
        }
    }
    
    // 根据百分比添加一个3D特效
    func menuTransformForPercent(percent: CGFloat) -> CATransform3D {
        
        var identify = CATransform3DIdentity
        // m34负责z轴方向的translation（移动），m34= -1/D,  默认值是0, D越小透视效果越明显,这边的1000视情况调整的
        identify.m34 = -1.0/1000
        
        let remainingPercent = 1.0 - percent
        let angle = remainingPercent * CGFloat(-M_PI_2)
        
        // 后面3个数为 x y z
        let rotationTransform = CATransform3DRotate(identify, angle, 0.0, 1.0, 0.0)
        // 将值转换成一个矩阵
        let translationTransform =
        CATransform3DMakeTranslation(menuWidth * percent, 0, 0)
        // 将上面两者结合起来
        return CATransform3DConcat(rotationTransform,
            translationTransform)
    }
    
    // 为按钮添加一个3D效果
    func buttonTransformForPercent(percent: CGFloat) -> CATransform3D {
        
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000

        let angle = percent * CGFloat(-M_PI)
        let rotationTransform = CATransform3DRotate(identity, angle, 1.0, 1.0, 0.0)
        
        return rotationTransform
    }
}
