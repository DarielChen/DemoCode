//
//  MenuItem.swift
//  SideMenu
//
//  Created by Dariel on 16/7/13.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit


let menuColors = [
    
    UIColor(red: 118/255, green: 165/255,  blue: 175/255,   alpha: 1.0),
    UIColor(red: 213/255,  green: 166/255,  blue: 189/255,  alpha: 1.0),
    UIColor(red: 106/255, green: 168/255, blue: 79/255,   alpha: 1.0),
    UIColor(red: 103/255,  green: 78/255, blue: 167/255,  alpha: 1.0),
    UIColor(red: 188/255, green: 238/255,  blue: 104/255, alpha: 1.0),
    UIColor(red: 102/255,  green: 139/255,  blue: 139/255, alpha: 1.0),
    UIColor(red: 230/255,  green: 145/255, blue: 56/255, alpha: 1.0)
    
]

class MenuItem {
    
    let title: String
    let symbol: String
    let color: UIColor
    
    init(symbol: String, color: UIColor, title: String) {
        self.symbol = symbol
        self.color  = color
        self.title  = title
    }
    
    class var sharedItems: [MenuItem] {
        struct Static {
            static let items = MenuItem.sharedMenuItems()
        }
        
        return Static.items
    }
    
    class func sharedMenuItems() -> [MenuItem] {
        
        var items = [MenuItem]()
        items.append(MenuItem(symbol: "🐱", color: menuColors[0], title: "鼠"))
        items.append(MenuItem(symbol: "🐂", color: menuColors[1], title: "牛"))
        items.append(MenuItem(symbol: "🐯", color: menuColors[2], title: "虎"))
        items.append(MenuItem(symbol: "🐰", color: menuColors[3], title: "兔"))
        items.append(MenuItem(symbol: "🐲", color: menuColors[4], title: "龙"))
        items.append(MenuItem(symbol: "🐍", color: menuColors[5], title: "蛇"))
        items.append(MenuItem(symbol: "🐴", color: menuColors[6], title: "马"))
        
        return items
    }
}
