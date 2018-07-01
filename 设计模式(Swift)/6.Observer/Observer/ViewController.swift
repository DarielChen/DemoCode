//
//  ViewController.swift
//  Observer
//
//  Created by  Dariel on 2018/5/7.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var kvoObserver: NSKeyValueObservation?
    var observer: Observer?
    
    
    let user = User(name: "Made")
    let kvoUser = KVOUser(name: "Dariel")


    override func viewDidLoad() {
        super.viewDidLoad()
        
        kvoObserver = kvoUser.observe(\.name, options: [.initial, .new]) {
            (user, change) in
            print("User's name is \(user.name)")
        }

        // swift4中KVO不需要移除了,观察者是弱引用
        
        observer = Observer()
        user.name.addObserver(observer!, options: [.new]) {
            name, change in
            print("name:\(name), change:\(change)")
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        kvoUser.name = "John"
        user.name.value = "Amel"
        
    }
    
}

@objcMembers public class KVOUser: NSObject {
    // @objcMembers 给每个属性添加 @objc 关键词

    dynamic var name: String

    public init(name: String) {
        self.name = name
    }
}


public class User {
    public let name: Observable<String>
    public init(name: String) {
        self.name = Observable(name)
    }
}
public class Observer {}

