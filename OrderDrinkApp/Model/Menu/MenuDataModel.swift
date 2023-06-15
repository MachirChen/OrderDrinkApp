//
//  MenuDataModel.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/10.
//

import Foundation

struct MenuDataModel: Codable {
    var records: [Record]
}

struct Record: Codable {
    let id: String
    let fields: Field
}

struct Field: Codable {
    let image: [Image]
    let description: String
    let large: Int?
    let medium: Int
    let name: String
}

struct Image: Codable {
    let url: String
}
