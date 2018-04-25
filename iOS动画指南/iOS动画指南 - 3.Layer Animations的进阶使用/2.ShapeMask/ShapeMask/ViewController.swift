//
//  ViewController.swift
//  ShapeMask
//
//  Created by Dariel on 16/6/21.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        avatar1.image = UIImage(named: "avatar-1")
        avatar2.image = UIImage(named: "avatar-2")
        avatar1.label.text = "FOX"
        avatar2.label.text = "DOG"

        view.addSubview(avatar1)
        view.addSubview(avatar2)
        

        view.backgroundColor = UIColor(red: 130/255.0, green: 209/255.0, blue: 93/255.0, alpha: 1)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let avatarSize = avatar1.frame.size
        
        let morphSize = CGSize(
            width: avatarSize.width * 0.85,
            height: avatarSize.height * 1.05)
        
        let bounceXOffset: CGFloat = view.frame.size.width/2.0 - avatar1.lineWidth*2 - avatar1.frame.width
        avatar2.boundsOffset(bounceXOffset, morphSize:morphSize)
        avatar1.boundsOffset(avatar1.frame.origin.x - bounceXOffset, morphSize:morphSize)
    } 

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    lazy var avatar1: AvatarView = {
    
        let avatarView = AvatarView()
//        avatarView.backgroundColor = UIColor.redColor()
        avatarView.frame = CGRect(x: self.view.frame.width-90-20, y: self.view.center.y, width: 90, height: 90)
        return avatarView
    }()
    
    lazy var avatar2: AvatarView = {
        let avatarView = AvatarView()
        avatarView.frame = CGRect(x: 20, y: self.view.center.y, width: 90, height: 90)
//        avatarView.backgroundColor = UIColor.orangeColor()
        return avatarView
    }()
    
}

