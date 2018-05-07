//
//  ViewController.swift
//  Memento
//
//  Created by  Dariel on 2018/5/3.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let userInfo = UserInfo.shared
        userInfo.isLogin = true
        userInfo.account = "132154"
        userInfo.age = 16

        // 保存
        do {
            try UserInfoTaker.save(userInfo)
        }catch {
            print(error)
        }

        // 读取
        do {
            let newUserInfo = try UserInfoTaker.load()
            
            dc.log(newUserInfo.description)
            dc.address(o: newUserInfo)
            
        }catch {
            print(error)
        }

        dc.log(userInfo.description)
        dc.address(o: userInfo)
    }
    
}



// MARK: - 发起人(Originator)
public class UserInfo: Codable {
    
    static let shared = UserInfo()
    private init() {}
    
    public var isLogin: Bool = false
    
    public var account: String?
    public var age: Int?
    
    var description: String {
        return "account:\(account ?? "为空"), age:\(age ?? 0)"
    }

}

// MARK: - Memento(备忘录): 负责存储Originator对象,swift中由Codable实现


// MARK: - (管理者)CareTaker
public class UserInfoTaker {
    
    public static let UserInforKey = "UserInfoKey"
    
    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()
    private static let userDefaults = UserDefaults.standard
    
    public static func save(_ p: UserInfo) throws {
        
        let data = try encoder.encode(p)

        userDefaults.set(data, forKey: UserInforKey)
    }
    
    public static func load() throws -> UserInfo {
        
        guard let data = userDefaults.data(forKey: UserInforKey),
            let userInfo = try? decoder.decode(UserInfo.self, from: data)
            
            else {
                throw Error.UserInfoNotFound
        }
        
        // decode生成的对象不是单例对象,需要转换成单例对象
        let userInfoS = UserInfo.shared
        userInfoS.account = userInfo.account
        userInfoS.age = userInfo.age
        userInfoS.isLogin = userInfo.isLogin
        
        return userInfoS
    }
    
    public enum Error: String, Swift.Error {
        case UserInfoNotFound
    }
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
