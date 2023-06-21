//
//  UIViewController+.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/8.
//

import UIKit

extension UIViewController {
    
    func setupShoppingCartButtonInNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(handleShoppingCart))
    }
    
    @objc private func handleShoppingCart() {
        let shoppingCartcontroller = ShoppingCartViewController()
        shoppingCartcontroller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(shoppingCartcontroller, animated: true)
    }
    
}
