//
//  CustomItemModel.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/13.
//

import Foundation

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

