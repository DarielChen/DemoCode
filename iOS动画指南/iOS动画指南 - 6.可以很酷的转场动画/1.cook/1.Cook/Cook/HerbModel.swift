//
//  HerbModel.swift
//  Cook
//
//  Created by Dariel on 16/7/24.
//  Copyright © 2016年 Dariel. All rights reserved.
//

struct HerbModel {
    let name: String
    let image: String
    
    static func all() -> [HerbModel] {
    
        return [
                HerbModel(name: "Saffron", image: "saffron.jpg"),
                HerbModel(name:"Basil", image: "basil.jpg"),
                HerbModel(name: "Marjoram", image: "marjorana.jpg"),
                HerbModel(name: "Rosemary", image: "rosemary.jpg"),
                HerbModel(name: "Anise", image: "anise.jpg")
        ]
    }
}
