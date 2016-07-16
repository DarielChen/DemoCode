//
//  ViewController.swift
//  SideMenu
//
//  Created by Dariel on 16/7/10.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var menuItem: MenuItem! {
        didSet {
            navigationItem.title = menuItem.title
            view.backgroundColor = menuItem.color
            symbol.text = menuItem.symbol
        }
    }
    
    var menuButton: MenuButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton = MenuButton()
     
        view.addSubview(symbol)
        symbol.center = self.view.center

        menuButton.tapHandler = {
            if let containerVC = self.navigationController?.parentViewController as? ContainerViewController {
                containerVC.toggleSideMenu()
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        menuItem = MenuItem.sharedItems.first!
    }
    
    lazy var symbol: UILabel = {
        let symbol = UILabel()
        symbol.font = UIFont.systemFontOfSize(140)
        symbol.frame.size = CGSize(width: 144, height: 168)
        symbol.textAlignment = .Center
        return symbol
    }()
}

