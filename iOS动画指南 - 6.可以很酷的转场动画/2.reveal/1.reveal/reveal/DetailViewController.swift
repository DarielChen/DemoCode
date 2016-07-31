//
//  DetailViewController.swift
//  reveal
//
//  Created by Dariel on 16/7/26.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let maskLayer: CAShapeLayer = RWLogoLayer.logoLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "DETAILVC"
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(bgImage)
        view.addSubview(descLabel)
        descLabel.sizeToFit()
        descLabel.center = view.center
        
        
        maskLayer.position = CGPoint(x: view.layer.bounds.size.width/2, y: view.layer.bounds.size.height/2)
        view.layer.mask = maskLayer
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        view.layer.mask = nil
    }
    
    
    lazy var descLabel : UILabel = {
        let label = UILabel()
        label.text = "DetailViewController"
        label.textColor = UIColor.cyanColor()
        label.font = UIFont.systemFontOfSize(30)
        return label
    }()
    
    lazy var bgImage: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: "anise")
        bg.frame = self.view.bounds
        return bg
    }()
}
