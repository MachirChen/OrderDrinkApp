//
//  ShoppingCartButton.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/25.
//

import UIKit
import SnapKit

class ShoppingCartButton: UIButton {
    
    let unpaidLightView: UIView = {
        let view = UIView()
        view.cornerRadii(radii: 4)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubview(unpaidLightView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        unpaidLightView.frame = CGRect(x: 20, y: -4, width: 8, height: 8)
    }

}
