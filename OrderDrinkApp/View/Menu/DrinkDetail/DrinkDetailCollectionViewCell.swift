//
//  DrinkDetailCollectionViewCell.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/9.
//

import UIKit
import SnapKit
import Kingfisher

class DrinkDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DrinkDetailCollectionViewCell"
        
    private let drinkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "白玉歐蕾")
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26)
        label.text = "Name"
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .kebukeYellow
        label.textAlignment = .right
        label.text = "Price"
        return label
    }()
    
    private let subtiltleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "subtiltle"
        return label
    }()
    
    private let sweetnessLevelBackgroundView = UIView()
    private let iceLevelBackgroundView = UIView()
    private let capacitySizeBackgroundView = UIView()
    private let toppingsBackgroundView = UIView()
    
    private var sweetnessStackView = UIStackView()
    private var iceStackView = UIStackView()
    private var capacitySizeStackView = UIStackView()
    private var toppingsStackView = UIStackView()
    
    private var sweetnessTitleLabel: UILabel!
    private var iceTitleLabel: UILabel!
    private var capacitySizeTitleLabel: UILabel!
    private var toppingsTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGrayBackgroundView(view: capacitySizeBackgroundView, backgroundColor: .systemGray5)
        setupGrayBackgroundView(view: sweetnessLevelBackgroundView, backgroundColor: .systemGray5)
        setupGrayBackgroundView(view: iceLevelBackgroundView, backgroundColor: .systemGray5)
        setupGrayBackgroundView(view: toppingsBackgroundView, backgroundColor: .clear)
        
        setupView()
        backgroundColor = .green
        
        capacitySizeTitleLabel = createTitleLabel(text: "容量選擇")
        sweetnessTitleLabel = createTitleLabel(text: "甜度選擇")
        iceTitleLabel = createTitleLabel(text: "冰量選擇")
        toppingsTitleLabel = createTitleLabel(text: "加料選擇")

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupGrayBackgroundView(view: UIView, backgroundColor: UIColor) {
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        contentView.addSubview(view)
    }
    
    private func createTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = .black
        label.text = text
        contentView.addSubview(label)
        return label
    }
    
    private func setupButtonStackView(_ stackView: UIStackView, withData data: [String], in backgroundView: UIView, buttonStyle: selectionButton.ButtonStyle, buttonPriceTitle: [String]) {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        backgroundView.addSubview(stackView)
        for (index,name) in data.enumerated() {
            let button = createButtonWithTitle(name, priceTitle: buttonPriceTitle[index], buttonStyle: buttonStyle)
            stackView.addArrangedSubview(button)
        }
        contentView.addSubview(stackView)
    }
    
    private func setupButtonStackView(_ stackView: UIStackView, withData data: [String], in backgroundView: UIView, buttonStyle: selectionButton.ButtonStyle) {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        backgroundView.addSubview(stackView)
        for name in data {
            let button = createButtonWithTitle(name, priceTitle: nil, buttonStyle: buttonStyle)
            stackView.addArrangedSubview(button)
        }
        contentView.addSubview(stackView)
    }
    
    private func createButtonWithTitle(_ title: String, priceTitle: String?, buttonStyle: selectionButton.ButtonStyle) -> UIButton {
        let button = selectionButton()
        button.setTitle(title, priceTitle: priceTitle, buttonStyle: buttonStyle)
        button.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        button.title.font = .systemFont(ofSize: 18)
        button.priceTitle.font = .systemFont(ofSize: 16)
        return button
    }

    @objc private func handle(_ sender: UIButton) {
        print(sender)
    }
    
    private func setupView() {
        contentView.addSubview(drinkImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(subtiltleLabel)
    }
    
    private func setupLayout() {
        setupCapacitySizeLayout()
        setupIceLevelLayout()
        setupSweetnessLevelLayout()
        setupToppingsLayout()
        
        drinkImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(self.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(drinkImageView.snp.bottom)
            make.width.equalTo(200)
            make.leading.equalTo(self).offset(16)
            make.height.equalTo(50)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel)
            make.trailing.equalTo(self).offset(-16)
            make.leading.equalTo(nameLabel.snp.trailing)
            make.height.equalTo(24)
        }
        
        subtiltleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.width.equalTo(self)
            make.leading.equalTo(self).offset(16)
            make.height.equalTo(24)
        }
        
    }
    
    private func setupCapacitySizeLayout() {
        capacitySizeBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(subtiltleLabel.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-30)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(capacitySizeStackView.snp.bottom).offset(30)
        }
        
        capacitySizeStackView.snp.makeConstraints { make in
            make.top.equalTo(capacitySizeTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
        
        capacitySizeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(capacitySizeBackgroundView.snp.top).offset(10)
            make.leading.equalTo(capacitySizeBackgroundView).offset(20)
            make.trailing.equalTo(capacitySizeBackgroundView).offset(-30)
            make.height.equalTo(30)
        }
    }
    
    private func setupIceLevelLayout() {
        iceLevelBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(sweetnessLevelBackgroundView.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-30)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(iceStackView.snp.bottom).offset(30)
        }
        
        iceStackView.snp.makeConstraints { make in
            make.top.equalTo(iceTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
        
        iceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iceLevelBackgroundView.snp.top).offset(10)
            make.leading.equalTo(iceLevelBackgroundView).offset(20)
            make.trailing.equalTo(iceLevelBackgroundView).offset(-30)
            make.height.equalTo(30)
        }
    }
    
    private func setupSweetnessLevelLayout() {
        sweetnessLevelBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(capacitySizeBackgroundView.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-30)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(sweetnessStackView.snp.bottom).offset(30)
        }
        
        sweetnessStackView.snp.makeConstraints { make in
            make.top.equalTo(sweetnessTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
        
        sweetnessTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sweetnessLevelBackgroundView.snp.top).offset(10)
            make.leading.equalTo(sweetnessLevelBackgroundView).offset(20)
            make.trailing.equalTo(sweetnessLevelBackgroundView).offset(-30)
            make.height.equalTo(30)
        }
    }
    
    private func setupToppingsLayout() {
        toppingsBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(iceLevelBackgroundView.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-30)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(toppingsStackView.snp.bottom).offset(30)
        }

        toppingsStackView.snp.makeConstraints { make in
            make.top.equalTo(toppingsTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
        
        toppingsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(toppingsBackgroundView.snp.top).offset(10)
            make.leading.equalTo(toppingsBackgroundView).offset(20)
            make.trailing.equalTo(toppingsBackgroundView).offset(-30)
            make.height.equalTo(30)
        }
    }
    
    func layoutCell(drinkInfo: Record, capacitySize: [String], temperature: [String], sweetness: [String], toppings: [String], sizePrice: [String], toppingsPrice: [String]) {
        let drinkInfo = drinkInfo.fields
        self.nameLabel.text = drinkInfo.name
        self.priceLabel.text = "$\(drinkInfo.medium)"
        self.subtiltleLabel.text = drinkInfo.description
        
        let imageURL = URL(string: drinkInfo.image[0].url)
        self.drinkImageView.kf.indicatorType = .activity
        self.drinkImageView.kf.setImage(with: imageURL)
        
        setupButtonStackView(capacitySizeStackView, withData: capacitySize, in: capacitySizeBackgroundView, buttonStyle: .circleView, buttonPriceTitle: sizePrice)
        setupButtonStackView(sweetnessStackView, withData: sweetness, in: sweetnessLevelBackgroundView, buttonStyle: .circleView)
        setupButtonStackView(iceStackView, withData: temperature, in: iceLevelBackgroundView, buttonStyle: .circleView)
        setupButtonStackView(toppingsStackView, withData: toppings, in: toppingsBackgroundView, buttonStyle: .roundedView, buttonPriceTitle: toppingsPrice)
    }

}
