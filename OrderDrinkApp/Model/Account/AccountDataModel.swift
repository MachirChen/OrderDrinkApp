//
//  AccountDataModel.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/29.
//

import Foundation

struct Account: Codable {
    let userID: String
    var name: String = "匿名"
    var image: String?
}
