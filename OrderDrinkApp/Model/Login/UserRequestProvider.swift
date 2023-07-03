//
//  UserRequestProvider.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/27.
//

import Foundation
import FirebaseAuth

class UserRequestProvider {
    
    static let shared = UserRequestProvider()
    
    var currentUser: User? {
        firebaseAuth.currentUser
    }
    
    lazy var firebaseAuth = Auth.auth()
    
    func listenFirebaseLoginSendAccount(completion: @escaping (Result<Account?, Error>) -> Void) {
        firebaseAuth.addStateDidChangeListener { _, user in
            guard let id = user?.uid else { return }
            AccountRequestProvider.shared.fetchAccount(currentUserID: id) { result in
                switch result {
                case .success(let account):
                    completion(.success(account))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func signUp(withEmail email: String, withPassword password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed to create user in firebase:", error.localizedDescription)
                completion(.failure(error))
            }
            guard let user = result?.user else { return }
            AccountRequestProvider.shared.createAccount(currentUserID: user.uid)
            completion(.success(()))
        }
    }
    
    func signIn(withEmail email: String, withPassword password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                print("Failed to sign in user:", error.localizedDescription)
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func logOut() {
        do {
            try firebaseAuth.signOut()
        } catch {
            print("Failed to sign out:", error)
        }
    }
    
}
