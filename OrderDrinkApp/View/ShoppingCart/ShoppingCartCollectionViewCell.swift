//
//  ShoppingCartCollectionViewCell.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/16.
//

import UIKit
import SnapKit

protocol ShoppingCartCollectionViewCellDelegate: AnyObject {
    func didTapMinusButton(in cell: ShoppingCartCollectionViewCell)
    func didTapPlusButton(in cell: ShoppingCartCollectionViewCell)
}

class ShoppingCartCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ShoppingCartCollectionViewCell"
    
    weak var delegate: ShoppingCartCollectionViewCellDelegate?
    
    private let drinkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "白玉歐蕾")
        return imageView
    }()
    
    private let drinkNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "Name"
        return label
    }()
    
    private let drinkCustomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "少冰, 正常糖, 白玉珍珠, 水玉"
        label.textColor = .lightGray
        return label
    }()
    
    private let drinkPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "$199"
        label.textColor = .kebukeBlue
        return label
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .kebukeYellow
        return button
    }()
    
    private func setupButtonActions() {
        minusButton.addTarget(self, action: #selector(tapMinusButton), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(tapPlusButton), for: .touchUpInside)
    }

    
    @objc private func tapMinusButton(sender: UIButton) {
        delegate?.didTapMinusButton(in: self)
    }
    
    @objc private func tapPlusButton(sender: UIButton) {
        delegate?.didTapPlusButton(in: self)
    }
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.backgroundColor = .clear
        label.textColor = .kebukeYellow
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .clear
        button.tintColor = .kebukeYellow
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupButtonActions()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [minusButton, quantityLabel, plusButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        contentView.addSubview(stackView)
        contentView.addSubview(drinkImageView)
        contentView.addSubview(drinkNameLabel)
        contentView.addSubview(drinkCustomLabel)
        contentView.addSubview(drinkPriceLabel)
        drinkImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.leading.top.equalTo(self).offset(20)
        }
        
        drinkNameLabel.snp.makeConstraints { make in
            make.top.equalTo(drinkImageView.snp.top)
            make.leading.equalTo(drinkImageView.snp.trailing).offset(10)
            make.trailing.equalTo(self).offset(-10)
            make.height.equalTo(22)
        }
        
        drinkCustomLabel.snp.makeConstraints { make in
            make.top.equalTo(drinkNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(drinkNameLabel)
            make.height.equalTo(22)
        }
        
        drinkPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(drinkNameLabel)
            make.top.equalTo(drinkImageView.snp.bottom).offset(10)
            make.trailing.equalTo(stackView.snp.leading)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(drinkPriceLabel)
            make.trailing.equalTo(drinkNameLabel)
            make.width.equalTo(100)
        }
    }
    
    func layoutCell(drink order: OrderResponse.Record) {
        guard let imageUrlStr = order.fields.image[0].url else { return }
        let imageURL = URL(string: imageUrlStr)
        self.drinkImageView.kf.indicatorType = .activity
        self.drinkImageView.kf.setImage(with: imageURL)
        
        self.drinkNameLabel.text = order.fields.drink
        if let toppings = order.fields.toppings {
            self.drinkCustomLabel.text = "\(order.fields.temperature), \(order.fields.sweetness), \(toppings)"
        } else {
            self.drinkCustomLabel.text = "\(order.fields.temperature), \(order.fields.sweetness)"
        }
        self.drinkPriceLabel.text = "$\(order.fields.price)"
        self.quantityLabel.text = "\(order.fields.quantity)"
    }
    
    
}
