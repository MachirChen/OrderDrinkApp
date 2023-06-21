//
//  DrinkDetailCollectionViewCell.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/9.
//

import UIKit
import SnapKit
import Kingfisher

protocol DrinkDetailCollectionViewCellDelegate: AnyObject {
    func didTapSizeButton(_ sender: SelectionButton, buttons: [SelectionButton], background: UIView)
    func didTapIceButton(_ sender: SelectionButton, buttons: [SelectionButton], background: UIView)
    func didTapSweetnessButton(_ sender: SelectionButton, buttons: [SelectionButton], background: UIView)
    func didTapToppingButton(_ sender: SelectionButton, buttons: [SelectionButton], background: UIView)
}

class DrinkDetailCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DrinkDetailCollectionViewCell"
    
    weak var delegate: DrinkDetailCollectionViewCellDelegate?
        
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
    
    private var sweetnessButtons: [SelectionButton] = []
    private var iceButtons: [SelectionButton] = []
    private var sizeButtons: [SelectionButton] = []
    private var toppingButtons: [SelectionButton] = []

    private let sweetnessLevelBackgroundView = UIView()
    private let iceLevelBackgroundView = UIView()
    private let capacitySizeBackgroundView = UIView()
    private let toppingsBackgroundView = UIView()
    
    private var sweetnessTitleLabel: UILabel!
    private var iceTitleLabel: UILabel!
    private var capacitySizeTitleLabel: UILabel!
    private var toppingsTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGrayBackgroundView(view: capacitySizeBackgroundView, backgroundColor: .alertRed)
        setupGrayBackgroundView(view: sweetnessLevelBackgroundView, backgroundColor: .alertRed)
        setupGrayBackgroundView(view: iceLevelBackgroundView, backgroundColor: .alertRed)
        setupGrayBackgroundView(view: toppingsBackgroundView, backgroundColor: .systemGray5)
        
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
    
    func layoutCell(drinkInfo: Record, size: [Item], temperature: [Item], sweetness: [Item], toppings: [Item]) {
        let drinkInfo = drinkInfo.fields
        self.nameLabel.text = drinkInfo.name
        self.priceLabel.text = "$\(drinkInfo.medium)"
        self.subtiltleLabel.text = drinkInfo.description
        
        let imageURL = URL(string: drinkInfo.image[0].url)
        self.drinkImageView.kf.indicatorType = .activity
        self.drinkImageView.kf.setImage(with: imageURL)

        sizeButtons = createButtons(items: size, style: .circleView, action: #selector(handleSizeButton))
        iceButtons = createButtons(items: temperature, style: .circleView, action: #selector(handleIceButton))
        sweetnessButtons = createButtons(items: sweetness, style: .circleView, action: #selector(handleSweetnessButton))
        toppingButtons = createButtons(items: toppings, style: .roundedView, action: #selector(handleToppingButton))
        setupLayout()
    }
    
    @objc private func handleSizeButton(_ sender: SelectionButton) {
        delegate?.didTapSizeButton(sender, buttons: sizeButtons, background: capacitySizeBackgroundView)
        print(toppingsBackgroundView.frame.origin)
        print(toppingsBackgroundView.frame.maxY)
    }
    
    @objc private func handleIceButton(_ sender: SelectionButton) {
        delegate?.didTapIceButton(sender, buttons: iceButtons, background: iceLevelBackgroundView)
    }
    
    @objc private func handleSweetnessButton(_ sender: SelectionButton) {
        delegate?.didTapSweetnessButton(sender, buttons: sweetnessButtons, background: sweetnessLevelBackgroundView)
    }
    
    @objc private func handleToppingButton(_ sender: SelectionButton) {
        delegate?.didTapToppingButton(sender, buttons: toppingButtons, background: toppingsBackgroundView)
    }
    
    private func createButtons(items: [Item], style: SelectionButton.ButtonStyle, action: Selector) -> [SelectionButton] {
        var buttons: [SelectionButton] = []
        for (index, item) in items.enumerated() {
            let button = SelectionButton()
            button.setTitle(item.name, priceTitle: item.price, buttonStyle: style)
            button.tag = index
            button.addTarget(self, action: action, for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.height.equalTo(20)
            }
            button.title.font = .systemFont(ofSize: 18)
            button.priceTitle.font = .systemFont(ofSize: 16)
            buttons.append(button)
        }
        
        return buttons
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
        
        let stackView =  UIStackView(arrangedSubviews: sizeButtons)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        contentView.addSubview(stackView)
        
        capacitySizeBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(subtiltleLabel.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(stackView.snp.bottom).offset(30)
        }
        
        stackView.snp.makeConstraints { make in
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
        
        let stackView =  UIStackView(arrangedSubviews: iceButtons)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        contentView.addSubview(stackView)
        
        iceLevelBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(sweetnessLevelBackgroundView.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(stackView.snp.bottom).offset(30)
        }
        
        stackView.snp.makeConstraints { make in
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
        
        let stackView =  UIStackView(arrangedSubviews: sweetnessButtons)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        contentView.addSubview(stackView)
        
        sweetnessLevelBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(capacitySizeBackgroundView.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(stackView.snp.bottom).offset(30)
        }
        
        stackView.snp.makeConstraints { make in
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
        
        let stackView =  UIStackView(arrangedSubviews: toppingButtons)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        contentView.addSubview(stackView)
        
        toppingsBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(iceLevelBackgroundView.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(stackView.snp.bottom).offset(30)
        }

        stackView.snp.makeConstraints { make in
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
    


}
