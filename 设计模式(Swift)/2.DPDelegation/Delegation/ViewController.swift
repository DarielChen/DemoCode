//
//  ViewController.swift
//  Delegation
//
//  Created by  Dariel on 2018/4/25.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chooseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? MenuViewController else { return }
        
        viewController.delegate = self;
    }
}

extension ViewController: MenuViewControllerDelegate {
    
    func menuViewController(_ menuViewController: MenuViewController, didSelectItemAtIndex index: Int, chooseItem item: String) {
        
        chooseLabel.text = item
    }
    
    func didSelectItemAtIndex(_ index: Int) {
        
        print(index)
    }
    
}
