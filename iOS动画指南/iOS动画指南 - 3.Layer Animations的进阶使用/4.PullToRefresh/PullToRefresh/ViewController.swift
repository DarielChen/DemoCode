//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Dariel on 16/6/22.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

let refreshViewHeight: CGFloat = 110.0
class ViewController: UIViewController, RefreshViewDelegate {

    
    var refreshView: RefreshView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 64.0
        view.addSubview(tableView)
        
        
        // 封装下拉刷新控件
        let refreshRect = CGRect(x: 0.0, y: -refreshViewHeight, width: view.frame.width, height: refreshViewHeight)
        refreshView = RefreshView(frame: refreshRect, scrollView: tableView)
        refreshView!.delegate = self
        tableView.addSubview(refreshView!)
        
    }
    
    
    func refreshViewDidRefresh(refreshView: RefreshView) {
        delay(seconds: 4) {
            refreshView.endRefreshing()
        }
    }
    
}

// MARK: - UITableView代理
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        }
        cell!.textLabel!.text = String("这是第\(indexPath.row+1)个cell")
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("这是第\(indexPath.row+1)个cell")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        refreshView?.scrollViewDidScroll(scrollView)
    }
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        refreshView?.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
}

