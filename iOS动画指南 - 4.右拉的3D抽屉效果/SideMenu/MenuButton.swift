//
//  MenuButton.swift
//  SideMenu
//
//  Created by Dariel on 16/7/13.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class MenuButton: UIView {

    var imageView: UIImageView!
    var tapHandler: (()->())?
    
    override func didMoveToSuperview() {
        
        frame = CGRect(x: 0, y: 0, width: 20.0, height: 20.0)
        imageView = UIImageView(image: UIImage(named: "menu"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("didTap")))
        addSubview(imageView)
        
    }
    
    func didTap() {
        tapHandler?()
    }
}
