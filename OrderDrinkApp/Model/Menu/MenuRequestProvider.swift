//
//  MenuRequestProvider.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/10.
//

import Alamofire

class MenuRequestProvider {
    static let shared = MenuRequestProvider()
    
    func fetchMenu(completion: @escaping (Result<[Record], Error>) -> Void) {
        let urlStr = "https://api.airtable.com/v0/appgfDIC0LO9O3n4q/Menu"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer keyGfh2XBwXYxG68d",
            "Accept": "application/json"
        ]
        
        AF.request(urlStr, method: .get, headers: headers).responseDecodable(of: Menu.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data.records))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
