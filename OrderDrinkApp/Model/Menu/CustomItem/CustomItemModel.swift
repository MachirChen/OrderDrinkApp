//
//  CustomItemModel.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/13.
//

import Foundation

struct CustomItem {
    
    let iceLevel = [
        Item(name: "去冰", price: nil),
        Item(name: "微冰", price: nil),
        Item(name: "少冰", price: nil),
        Item(name: "正常冰", price: nil),
        Item(name: "常溫", price: nil),
        Item(name: "溫", price: nil),
        Item(name: "熱", price: nil)
    ]
    
    let nonHotTemperature = [
        Item(name: "去冰", price: nil),
        Item(name: "微冰", price: nil),
        Item(name: "少冰", price: nil),
        Item(name: "正常冰", price: nil)
    ]

    let sugarLevel = [
        Item(name: "無糖", price: nil),
        Item(name: "一分糖", price: nil),
        Item(name: "微糖", price: nil),
        Item(name: "半糖", price: nil),
        Item(name: "少糖", price: nil),
        Item(name: "正常糖", price: nil)
    ]
    
    let twoSugarLevel = [
        Item(name: "減糖", price: nil),
        Item(name: "正常糖", price: nil)
    ]

    var size = [
        Item(name: "大杯", price: nil),
        Item(name: "中杯", price: nil)
    ]
    
    var oneSize = [
        Item(name: "中杯", price: nil)
    ]

    let toppings = [
        Item(name: "白玉珍珠", price: "+$ 10"),
        Item(name: "水玉", price: "+$ 10")
    ]
    
    let oneTopping = [
        Item(name: "水玉", price: "+$ 10")
    ]

}

struct Item {
    let name: String
    var price: String?
}


enum IceLevel: String, CaseIterable {
    case noIce = "去冰"
    case lowIce = "微冰"
    case lessIce = "少冰"
    case normal = "正常冰"
    case roomTemperature = "常溫"
    case warm = "溫"
    case hot = "熱"
}

enum SugarLevel: String, CaseIterable {
    case noSugar = "無糖"
    case oneSugar = "一分糖"
    case lowSugar = "微糖"
    case halfSugar = "半糖"
    case lessSugar = "少糖"
    case standard = "正常糖"
}

enum Size: String, CaseIterable {
    case large = "大杯"
    case medium = "中杯"
}

enum Toppings: String, CaseIterable {
    case bubble = "白玉珍珠"
    case agarPearl = "水玉"
}
