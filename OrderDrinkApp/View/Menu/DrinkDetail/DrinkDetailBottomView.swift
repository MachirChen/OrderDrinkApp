//
//  BottomView.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/14.
//

import UIKit
import SnapKit

protocol DrinkDetailBottomViewDelegate: AnyObject {
    func didTapOrderButton()
    func didTapMinusButton()
    func didTapPlusButton()
}

class DrinkDetailBottomView: UIView {
    
    weak var delegate: DrinkDetailBottomViewDelegate?
    
    private let orderButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("加入購物車", for: .normal)
        button.backgroundColor = .gray
        button.tintColor = .kebukeBlue
        button.cornerRadii(radii: 5)
        button.isEnabled = false
        return button
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .kebukeYellow
        button.isEnabled = false
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.backgroundColor = .clear
        label.textColor = .kebukeYellow
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .kebukeYellow
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateQuantityLabel(with value: Int) {
        quantityLabel.text = "\(value)"
    }
    
    public func updateMinusButtonAvailability(enabled: Bool) {
        minusButton.isEnabled = enabled
    }

    public func enableOrderButton() {
        orderButton.isEnabled = true
        orderButton.backgroundColor = .kebukeYellow
    }
    
    
    private func setupView() {
        
        let stackView = UIStackView(arrangedSubviews: [minusButton, quantityLabel, plusButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        addSubview(stackView)
        addSubview(orderButton)
        backgroundColor = .kebukeBlue
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(orderButton)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(orderButton.snp.leading).offset(-20)
        }
        
        orderButton.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-20)
            make.top.equalTo(self).offset(10)
            make.width.equalTo(250)
            make.height.equalTo(40)
        }
        
    }
    
    private func setupButtonActions() {
        orderButton.addTarget(self, action: #selector(tapOrderButton), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(tapPlusButton), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(tapMinusButton), for: .touchUpInside)
    }
    
    @objc private func tapOrderButton() {
        delegate?.didTapOrderButton()
    }

    @objc private func tapPlusButton() {
        delegate?.didTapPlusButton()
    }
    
    @objc private func tapMinusButton() {
        delegate?.didTapMinusButton()
    }
    
}
