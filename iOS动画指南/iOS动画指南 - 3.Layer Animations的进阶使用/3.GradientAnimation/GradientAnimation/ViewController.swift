//
//  ViewController.swift
//  GradientAnimation
//
//  Created by Dariel on 16/6/22.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = GradientLabel()
        label.center = view.center
        label.bounds = CGRect(x: 0, y: 0, width: 239, height: 44)
        label.text = "> 滑动来解锁"

        view.addSubview(label)
        view.backgroundColor = UIColor.darkGrayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

