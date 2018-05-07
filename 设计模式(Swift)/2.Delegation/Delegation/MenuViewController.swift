//
//  ViewController.swift
//  Delegation
//
//  Created by  Dariel on 2018/4/23.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

@objc protocol MenuViewControllerDelegate: class { // 限制协议实现的类型
    
    // 必须实现的方法
    func menuViewController(_ menuViewController: MenuViewController, didSelectItemAtIndex index: Int, chooseItem item: String)
    
    @objc optional func didSelectItemAtIndex(_ index: Int) // 可选方法
}

class MenuViewController: UIViewController {
    
   weak var delegate: MenuViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    let items = ["ITEMS 1", "ITEMS 2", "ITEMS 3", "ITEMS 4", "ITEMS 5", "ITEMS 6", "ITEMS 7", "ITEMS 8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.menuViewController(self, didSelectItemAtIndex: indexPath.row, chooseItem: items[indexPath.row])
        
        // 可选链式调用,当有一个方法的返回值为nil,会导致整个链式调用失败
        delegate?.didSelectItemAtIndex?(indexPath.row)
        
        self.navigationController?.popViewController(animated: true)
    }
}



