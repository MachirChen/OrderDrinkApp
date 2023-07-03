//
//  UIImageView+.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/21.
//

import UIKit

extension UIImageView {
    func fetchImage(url: String) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: url))
    }
}
