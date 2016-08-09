//
//  ViewController.swift
//  AddCell
//
//  Created by Dariel on 16/8/3.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    // NSManagedObject CoreData中存储的对象,增删改查只要找它就好了.
    // texts 就相当于AddCell.xcdatamodeld中的Entity名字
    var texts = [NSManagedObject]()
//    var texts = [String]()

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "单组数据的增删改查"
        automaticallyAdjustsScrollViewInsets = false
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1.拿到manageContext
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manageContext = appDelegate.managedObjectContext
        
        // 2.根据entityName获取请求
        let fetchRequest = NSFetchRequest(entityName: "Cell")
        
        // 3.判断获取数据
        do {
            let results = try manageContext.executeFetchRequest(fetchRequest)
            texts = results as! [NSManagedObject]
        } catch let error as NSError {
            print("存储失败\(error), \(error.userInfo)")
        }
    }
    
    @IBAction func addText(sender: AnyObject) {
        
        let alert = UIAlertController(title: "末尾添加一个cell", message: nil, preferredStyle: .Alert)
        let saveAction = UIAlertAction(title: "保存", style: .Default, handler: { (action:UIAlertAction) -> Void in
        
            let textfield = alert.textFields?.first
//            self.texts.append(textfield!.text!)
            self.saveName(textfield!.text!)
            self.tableView.reloadData()
        })

        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        alert.addTextFieldWithConfigurationHandler { ( _ ) -> Void in
            
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func saveName(cellText: String) {
        
        // 1.拿到managedObjectContext
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manageContext = appDelegate.managedObjectContext
        
        // 2.创建一个NSManagedObject对象插到manageContext中
        let entity = NSEntityDescription.entityForName("Cell", inManagedObjectContext: manageContext)
        let text = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: manageContext)
        
        // 3.设置属性并设置值
        text.setValue(cellText, forKey: "text")
        
        // 4.保存存储的数据
        do {
            // 保存数据
            try manageContext.save()
            // 添加到视图中
            texts.append(text)
        } catch let error as NSError {
            print("存储失败\(error), \(error.userInfo)")
        }
    }
    
    @IBAction func query(sender: AnyObject) {
        
        for var index = 0; index < texts.count; index++ {
            print("第\(index)个cell的CellText:\(texts[index].valueForKey("text")!)")
        }
        
    }
    
    @IBAction func deleteAll(sender: AnyObject) {
        
        // 依然老样子
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manageContext = appDelegate.managedObjectContext
        
        // 遍历删除
        for text:NSManagedObject in texts {
            manageContext.deleteObject(text)
        }
        
        // 保存数据
        do {
            try manageContext.save()
        } catch let error as NSError {
            print("存储失败\(error), \(error.userInfo)")
        }
        
        texts.removeAll()
        self.tableView.reloadData()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCellWithIdentifier("cell")
//        cell?.textLabel?.text = texts[indexPath.row]
        let text = texts[indexPath.row]
        // 通过KVC获取NSManagedObject的text属性
        cell!.textLabel!.text = text.valueForKey("text") as? String
        
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    
        // 拿到managedObjectContext
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manageContext = appDelegate.managedObjectContext
        
        // 传入需要删除的那个NSManagedObject
        manageContext.deleteObject(texts[indexPath.row])
        
        // 保存数据
        do {
            try manageContext.save()
        } catch let error as NSError {
            print("存储失败\(error), \(error.userInfo)")
        }
        
        texts.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let alert = UIAlertController(title: "修改cell内容", message: nil, preferredStyle: .Alert)
        let text = texts[indexPath.row]

        let saveAction = UIAlertAction(title: "保存", style: .Default, handler: { (action:UIAlertAction) -> Void in
            
            let textfield = alert.textFields?.first
            
            let text = self.texts[indexPath.row]
            
            // 老样子,拿到managedObjectContext
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let manageContext = appDelegate.managedObjectContext
            // 利用KVC修改属性
            text.setValue(textfield!.text!, forKey: "text")
            // 保存
            do {
                try manageContext.save()
            } catch let error as NSError {
                print("存储失败\(error), \(error.userInfo)")
            }
            
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        alert.addTextFieldWithConfigurationHandler { ( _ ) -> Void in
            alert.textFields?.first?.text = text.valueForKey("text")! as? String
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    

    
}