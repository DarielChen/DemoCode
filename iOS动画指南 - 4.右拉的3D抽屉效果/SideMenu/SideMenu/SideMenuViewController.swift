//
//  SideMenuViewController.swift
//  SideMenu
//
//  Created by Dariel on 16/7/10.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController {

    
    var mainVC: MainViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerClass(MenuCell.self, forCellReuseIdentifier: "MenuCell")        
        tableView.separatorStyle = .None
        view.backgroundColor = UIColor(red: 120/255.0, green: 150/255.0, blue: 156/255.0, alpha: 1)
        tableView.scrollEnabled = false
    }
    
   }

extension SideMenuViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItem.sharedItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.selectionStyle = .None
        let menuItem = MenuItem.sharedItems[indexPath.row]
        
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.font = UIFont(name: "Helvetica", size: 36.0)
        cell.textLabel?.textAlignment = .Center
        cell.textLabel?.text = menuItem.symbol
        
        cell.contentView.backgroundColor = menuItem.color
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView  {
        return tableView.dequeueReusableCellWithIdentifier("MenuCell")!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        mainVC.menuItem = MenuItem.sharedItems[indexPath.row]
        let containerVC = parentViewController as! ContainerViewController
        containerVC.toggleSideMenu()
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 84.0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64.0
    }
}


