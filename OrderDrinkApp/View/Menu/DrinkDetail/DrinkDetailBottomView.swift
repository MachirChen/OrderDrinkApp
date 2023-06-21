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
    func didTapMinusButton(minusButton: UIButton, plusButton: UIButton, quantityLabel: UILabel)
    func didTapPlusButton(plusButton: UIButton, minusButton: UIButton, quantityLabel: UILabel)
}

class DrinkDetailBottomView: UIView {
    
    weak var delegate: DrinkDetailBottomViewDelegate?
    
    private let bottomControlView: UIView = {
        let view = UIView()
        view.backgroundColor = .kebukeBlue
        return view
    }()
    
    let orderButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("加入購物車", for: .normal)
        button.backgroundColor = .gray
        button.tintColor = .kebukeBlue
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
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
    
    private func setupView() {
        addSubview(bottomControlView)
        addSubview(orderButton)
        let stackView = UIStackView(arrangedSubviews: [minusButton, quantityLabel, plusButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(orderButton)
            make.leading.equalTo(bottomControlView).offset(20)
            make.trailing.equalTo(orderButton.snp.leading).offset(-20)
        }
        
        bottomControlView.snp.makeConstraints { make in
            make.trailing.leading.top.bottom.equalTo(self)
        }
        
        orderButton.snp.makeConstraints { make in
            make.trailing.equalTo(bottomControlView).offset(-20)
            make.top.equalTo(bottomControlView).offset(10)
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
        delegate?.didTapPlusButton(plusButton: plusButton, minusButton: minusButton, quantityLabel: quantityLabel)
    }
    
    @objc private func tapMinusButton(_ sender: UIButton) {
        delegate?.didTapMinusButton(minusButton: minusButton, plusButton: plusButton, quantityLabel: quantityLabel)
    }
    
}
