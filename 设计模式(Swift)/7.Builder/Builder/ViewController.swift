//
//  ViewController.swift
//  Builder
//
//  Created by  Dariel on 2018/5/7.
//  Copyright © 2018年 Dariel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = ManagerStatistics()
        
        if let Lucy = try? manager.createLucyData() {
            print(Lucy.description)
            print(Lucy.character)
            print(Lucy.hobby)

        }else {
            print("Out of area here")
        }
        
        if let Lilei = try? manager.createLiLeiData() {
            print(Lilei.description)
            print(Lilei.character)
            print(Lilei.hobby)
        }
        
    }
}


// MARK: - Builder
public class PersonStatistics {
    public private(set) var area: Area = .HangZhou
    public private(set) var characters: Character = []
    public private(set) var hobbys: Hobby = []
    
    private var outOfAreas: [Area] = [.Toronto]
    
    public func addCharacter(_ character: Character) {
        characters.insert(character)
    }
    
    public func removeCharacter(_ character: Character) {
        characters.remove(character)
    }
    
    public func addHobby(_ hobby: Hobby) {
        hobbys.insert(hobby)
    }
    
    public func removeHobby(_ hobby: Hobby) {
        hobbys.remove(hobby)
    }
    
    public func setArea(_ area: Area) throws {
        guard isAvailable(area) else { throw Error.OutOfArea }
        self.area = area
    }
    
    public func build() -> Person {
        return Person(area: area, character: characters, hobby: hobbys)
    }
    
    public func isAvailable(_ area: Area) -> Bool {
        return !outOfAreas.contains(area)
    }
    
    public enum Error: Swift.Error {
        case OutOfArea
    }
}



// MARK: - Product
public struct Person {
    public let area: Area
    public let character: Character
    public let hobby: Hobby
}

extension Person: CustomStringConvertible {
    public var description: String {
        return area.rawValue + character.description
    }
}

public enum Area: String { // 来自区域
    case ShangHai
    case ShenZhen
    case HangZhou
    case Toronto
}


public struct Character: OptionSet { // 性格
    
    public static let independent = Character(rawValue: 1 << 1)
    public static let ambitious = Character(rawValue: 1 << 2)
    public static let outgoing = Character(rawValue: 1 << 3)
    public static let unselfish = Character(rawValue: 1 << 4)
    public static let expressivity = Character(rawValue: 1 << 5)

    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
}


public struct Hobby: OptionSet { // 爱好
    
    public static let mountaineering = Hobby(rawValue: 1 << 1) // 2
    public static let boating = Hobby(rawValue: 1 << 2) // 4
    public static let climbing = Hobby(rawValue: 1 << 3) // 8
    public static let running = Hobby(rawValue: 1 << 4) // 16
    public static let camping = Hobby(rawValue: 1 << 5) // 32
    
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}


// MARK: - Director
public class ManagerStatistics {
    
    public func createLiLeiData() throws -> Person {
        let builder = PersonStatistics()
        try builder.setArea(.HangZhou)
        builder.addCharacter(.ambitious)
        builder.addHobby([.climbing, .boating, .camping])
        return builder.build()
    }
    
    public func createLucyData() throws -> Person {
        let builder = PersonStatistics()
        try builder.setArea(.Toronto)
        builder.addCharacter([.ambitious, .independent, .outgoing])
        builder.addHobby([.boating, .climbing, .camping])
        return builder.build()
    }
    
}



