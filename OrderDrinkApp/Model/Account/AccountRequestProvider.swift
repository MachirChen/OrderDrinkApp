//
//  AccountRequestProvider.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/29.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class AccountRequestProvider {
    static let shared = AccountRequestProvider()
    
    private lazy var database = Firestore.firestore()
    
    func createAccount(currentUserID: String) {
        let account = Account(userID: currentUserID)
        let documentReference = database.collection("accounts").document(currentUserID)
        do {
            try documentReference.setData(from: account)
        } catch {
            print("Failed to create account in firestore:", error)
        }
    }
    
    func fetchAccount(currentUserID: String, completion: @escaping (Result<Account?, Error>) -> Void) {
        database.collection("accounts").whereField("userID", isEqualTo: currentUserID).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                print("Failed to fetch accounts:", error)
            } else {
                guard let snapshot = snapshot else { return }
                if snapshot.isEmpty {
                    completion(.success(nil))
                } else {
                    if let account = snapshot.documents.compactMap({ try? $0.data(as: Account.self) }).first {
                        completion(.success(account))
                    } else {
                        completion(.success(nil))
                    }
                }
            }
        }
    }
    
}
