//
//  HerbDetailsViewController.swift
//  Cook
//
//  Created by Dariel on 16/7/24.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class HerbDetailsViewController: UIViewController {
    
    var herb: HerbModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgImage.image = UIImage(named: herb.image)
        view.addSubview(bgImage)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("actionClose:")))

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func actionClose(tap: UITapGestureRecognizer) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    lazy var bgImage: UIImageView = {
        let bg = UIImageView()
        bg.frame = self.view.bounds
        return bg
    }()
    
    
}
