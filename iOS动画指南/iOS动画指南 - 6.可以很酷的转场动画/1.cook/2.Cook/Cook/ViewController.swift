//
//  ViewController.swift
//  Cook
//
//  Created by Dariel on 16/7/24.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    let herbs = HerbModel.all()
    var selectedImage: UIImageView?
    
    
    let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bgImage)
        view.addSubview(listView)
        
        if listView.subviews.count < herbs.count {
            setUpList()
        }
        
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    func setUpList() {
    
        for var i=0; i < herbs.count; i++ {
        
            let imageView = UIImageView(image: UIImage(named: herbs[i].image))
            imageView.tag = i+3
            imageView.contentMode = .ScaleAspectFill
            imageView.userInteractionEnabled = true
            imageView.layer.cornerRadius = 20.0
            imageView.layer.masksToBounds = true
            listView.addSubview(imageView)
            
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTapImageView:")))
        }
        
        listView.backgroundColor = UIColor.clearColor()
        positionListItems()
    }
    
    func positionListItems() {
        
        let itemHeight: CGFloat = listView.frame.height * 1.33
        let aspectRatio = UIScreen.mainScreen().bounds.height / UIScreen.mainScreen().bounds.width
        let itemWidth: CGFloat = itemHeight / aspectRatio
        
        let horizontalPadding: CGFloat = 10.0
        
        for var i=0; i < herbs.count; i++ {
            let imageView = listView.viewWithTag(i+3) as! UIImageView
            imageView.frame = CGRect(
                x: CGFloat(i) * itemWidth + CGFloat(i+1) * horizontalPadding, y: 0.0,
                width: itemWidth, height: itemHeight)
        }
        listView.contentSize = CGSize(
            width: CGFloat(herbs.count) * (itemWidth + horizontalPadding) + horizontalPadding,
            height:  0)
    }

    

    func didTapImageView(tap: UITapGestureRecognizer) {
        selectedImage = tap.view as? UIImageView
        
        let index = tap.view!.tag
        let selectedHerb = herbs[index - 3]
        let herbDetailsVc = HerbDetailsViewController()
        herbDetailsVc.herb = selectedHerb
        herbDetailsVc.transitioningDelegate = self
        presentViewController(herbDetailsVc, animated: true, completion: nil)
        
    }
    // MARK: - 懒加载
    lazy var listView: UIScrollView = {
        let listView = UIScrollView()
        listView.frame = CGRect(x: 0, y: UIScreen.mainScreen().bounds.height-198, width:UIScreen.mainScreen().bounds.width , height: 198)
        listView.showsHorizontalScrollIndicator = false
        listView.showsVerticalScrollIndicator = false
        return listView
    }()
    
    lazy var bgImage: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: "bg")
        bg.frame = self.view.bounds
        return bg
    }()
}


extension ViewController: UIViewControllerTransitioningDelegate {

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return transition
    }
    
    

}


