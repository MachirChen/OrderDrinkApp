//
//  MenuRequestProvider.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/10.
//

import Alamofire

class MenuRequestProvider {
    static let shared = MenuRequestProvider()
    private let apiKey = "keyGfh2XBwXYxG68d"
    
    func fetchMenu(completion: @escaping (Result<[Record], Error>) -> Void) {
        let urlStr = "https://api.airtable.com/v0/appgfDIC0LO9O3n4q/Menu"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)",
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
