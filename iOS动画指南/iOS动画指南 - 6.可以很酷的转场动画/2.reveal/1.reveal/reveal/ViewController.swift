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
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("didTap"))
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        logo.position = CGPoint(x: view.layer.bounds.size.width/2,
            y: view.layer.bounds.size.height/2 + 30)
        logo.fillColor = UIColor.whiteColor().CGColor
        view.layer.addSublayer(logo)
    }
    
    func didTap() {
        navigationController?.pushViewController(DetailViewController(), animated: true)
    }
}

extension ViewController : UINavigationControllerDelegate {
    
    /**
     - parameter navigationController: 拿到设置代理的导航控制器
     - parameter operation:            .Push .Pop
     - parameter fromVC:               原来的控制器
     - parameter toVC:                 目标控制器
     
     - returns: 返回设置好的转场动画
     */
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.operation = operation
        return transition
    }
}





