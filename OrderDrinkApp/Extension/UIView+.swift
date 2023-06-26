//
//  UIView+.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/21.
//

import UIKit

extension UIView {
    
    func cornerRadii(radii: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radii
    }
    
}
