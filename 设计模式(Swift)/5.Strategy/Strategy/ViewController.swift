//
//  ViewController.swift
//  Strategy
//
//  Created by  Dariel on 2018/4/26.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

public class ViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let money: Double = 800
        
        let normalPrice = DisCountContext(style: .normal).getResult(money: money)
        let rebatePrice = DisCountContext(style: .rebate(rebate: 8)).getResult(money: money)
        let returnPrice = DisCountContext(style: .return(moneyCondition: 100, moneyReturn: 20)).getResult(money: money)
        
        
        print("正常价格:\(normalPrice)")
        print("打八折:\(rebatePrice)")
        print("满100返20:\(returnPrice)")
        
    }
}


// 策略协议
protocol DiscountStrategy {
    // 支付价格
    func payment(money: Double) -> Double
}


// 原价购买
class DiscountNormal: DiscountStrategy {
    func payment(money: Double) -> Double {
        return money
    }
}

// 打折
class DiscountRebate: DiscountStrategy {
    private let rebate: Double // 折扣
    
    init(rebate: Double) {
        self.rebate = rebate
    }
    func payment(money: Double) -> Double {
        return money * rebate/10.0
    }
}

// 返现
class DiscountReturn: DiscountStrategy {
    private let moneyCondition: Double // 满
    private let moneyReturn: Double // 返

    init(moneyCondition: Double, moneyReturn: Double) {
        self.moneyCondition = moneyCondition
        self.moneyReturn = moneyReturn
    }
    
    func payment(money: Double) -> Double {
        return money - (Double(Int(money/moneyCondition)) * moneyReturn)
    }
}

// 策略枚举
enum PayMentStyle {
    case normal
    case rebate(rebate: Double)
    case `return`(moneyCondition: Double, moneyReturn: Double)
}

// 策略管理
class DisCountContext {
    var discountStrategy: DiscountStrategy?
    
    init(style: PayMentStyle) {
        switch style { // 对应的三种方式
        case .normal:
            discountStrategy = DiscountNormal()
            
        case .rebate(rebate: let money):
            discountStrategy = DiscountRebate(rebate: money)
            
        case .return(moneyCondition: let condition, moneyReturn: let `return`):
            discountStrategy = DiscountReturn(moneyCondition: condition, moneyReturn: `return`)
            
        }
    }
    
    func getResult(money: Double) -> Double {
       return discountStrategy?.payment(money: money) ?? 0
    }
}



