//
//  ViewController.swift
//  reveal
//
//  Created by Dariel on 16/7/26.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let logo = RWLogoLayer.logoLayer()
    let transition = RevealAnimator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGrayColor()
        navigationItem.title = "START"
        navigationController?.delegate = self
        
        
        promptLabel.sizeToFit()
        promptLabel.center = CGPoint(x: UIScreen.mainScreen().bounds.width / 2.0, y: UIScreen.mainScreen().bounds.height - 80)
        view.addSubview(promptLabel)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        let tap = UITapGestureRecognizer(target: self, action: Selector("didTap"))
//        view.addGestureRecognizer(tap)
        
        
        let pan = UIPanGestureRecognizer(target: self, action: Selector("didPan:"))
        view.addGestureRecognizer(pan)
        
        
        logo.position = CGPoint(x: view.layer.bounds.size.width/2,
            y: view.layer.bounds.size.height/2 + 30)
        logo.fillColor = UIColor.whiteColor().CGColor
        view.layer.addSublayer(logo)
    }
    
//    func didTap() {
//        navigationController?.pushViewController(DetailViewController(), animated: true)
//    }
    
    func didPan(recognizer: UIPanGestureRecognizer) {
    
        switch recognizer.state {
        case .Began:
            transition.interactive = true
            navigationController?.pushViewController(DetailViewController(), animated: true)
        default:
            transition.handlePan(recognizer)
        }
    
    }
    
    lazy var promptLabel: UILabel = {
    
        let prompt = UILabel()
        prompt.text = "滑 动 解 锁"
        prompt.textColor = UIColor.whiteColor()
        prompt.font = UIFont.systemFontOfSize(20)
        return prompt
    }()
    
    
}

extension ViewController : UINavigationControllerDelegate {
    
    /**
     - parameter navigationController: 拿到设置代理的导航控制器
     - parameter operation:            .Push .Pop
     - parameter fromVC:               原来的控制器
     - parameter toVC:                 目标控制器
     
     - returns: 返回一个不可交互的转场动画
     */
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.operation = operation
        return transition
    }
    
    // 返回一个可以交互的转场动画
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
       
        
        if !transition.interactive {
            return nil
        }
        return transition
    }
    
}





