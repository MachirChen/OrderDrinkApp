//
//  OrderRequestProvider.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/19.
//

import Foundation
import Alamofire

class OrderRequestProvider {
    static let shared = OrderRequestProvider()
    
    func uploadDrink(data: Order) {
        let urlStr = "https://api.airtable.com/v0/appgfDIC0LO9O3n4q/OrderList"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer keyGfh2XBwXYxG68d",
            "Accept": "application/json"
        ]
        
        AF.request(urlStr, method: .post, parameters: data, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            debugPrint(response)
        }
    }
    
    func fetchOrderData(completion: @escaping (Result<[OrderResponse.Record], Error>) -> Void) {
        let urlStr = "https://api.airtable.com/v0/appgfDIC0LO9O3n4q/OrderList"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer keyGfh2XBwXYxG68d",
            "Accept": "application/json"
        ]

        AF.request(urlStr, method: .get, headers: headers).responseDecodable(of: OrderResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.records))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    

    
    func deleteOrder(id: String) {
        let urlStr = "https://api.airtable.com/v0/appgfDIC0LO9O3n4q/OrderList/\(id)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer keyGfh2XBwXYxG68d"
        ]

        AF.request(urlStr, method: .delete, headers: headers).response { response in
            debugPrint("Response: \(response)")
        }
    }
    
    func updateOrder(data: OrderResponse) {
        let urlStr = "https://api.airtable.com/v0/appgfDIC0LO9O3n4q/OrderList"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer keyGfh2XBwXYxG68d",
            "Accept": "application/json"
        ]
        
        AF.request(urlStr, method: .patch, parameters: data, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            debugPrint(response)
        }
    }
}

