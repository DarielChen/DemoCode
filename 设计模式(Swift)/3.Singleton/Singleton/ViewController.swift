//
//  ViewController.swift
//  Singleton
//
//  Created by  Dariel on 2018/4/30.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s1 = MySingleton.shared
        let s2 = MySingleton.shared
//        let s3 = MySingleton() // 报错
        
        
        dc.address(o: s1)
        dc.address(o: s2)

    }
    
}


final public class MySingleton {
    static let shared = MySingleton()
    private init() {}
}


public struct dc {
    
    public static func log<T>(_ message: T, file: NSString = #file, method: String = #function, line: Int = #line) {
        #if DEBUG
        print("\(file.pathComponents.last!):\(method)[\(line)]: \(message)")
        #endif
    }
    
    public static func address<T: AnyObject>(o: T, file: NSString = #file, method: String = #function, line: Int = #line) {
        log(String.init(format: "%018p", unsafeBitCast(o, to: Int.self)), file: file, method: method, line:line)
    }
}

