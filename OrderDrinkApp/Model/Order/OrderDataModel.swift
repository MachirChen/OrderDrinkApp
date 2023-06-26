//
//  OrderDataModel.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/19.
//

import Foundation

struct Order: Encodable {
    var records: [Record]
    
    struct Record: Encodable {
        let fields: Field
    }
    
    struct Field: Encodable {
        var drink: String
        var temperature: String
        var sweetness: String
        var toppings: String?
        var quantity: Int
        var price: Int
        let image: [Image]
    }
    
    struct Image: Encodable {
        let url: String
    }
    
}

struct OrderResponse: Codable {
    var records: [Record]
    
    struct Record: Codable {
        let id: String
        var fields: Field
    }
    
    struct Field: Codable {
        let drink: String
        var temperature: String
        var sweetness: String
        var toppings: String?
        var quantity: Int
        var price: Int
        let image: [Image]
    }
    
    struct Image: Codable {
        let id: String
        let url: String?
    }
    
}





