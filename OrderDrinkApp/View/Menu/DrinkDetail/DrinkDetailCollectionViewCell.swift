//
//  DrinkDetailCollectionViewCell.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/9.
//

import UIKit
import SnapKit

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
        label.textColor = .darkGray
        label.text = "subtiltle"
        return label
    }()
    
    private var sweetnessButtons: [SelectionButton] = []
    private var temperatureButtons: [SelectionButton] = []
    private var sizeButtons: [SelectionButton] = []
    private var toppingButtons: [SelectionButton] = []

    private let sweetnessBackgroundView = UIView()
    private let temperatureBackgroundView = UIView()
    private let sizeBackgroundView = UIView()
    private let toppingBackgroundView = UIView()
    
    private var sweetnessTitleLabel: UILabel!
    private var temperatureTitleLabel: UILabel!
    private var sizeTitleLabel: UILabel!
    private var toppingTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundView(view: sizeBackgroundView, backgroundColor: .alertRed)
        setupBackgroundView(view: sweetnessBackgroundView, backgroundColor: .alertRed)
        setupBackgroundView(view: temperatureBackgroundView, backgroundColor: .alertRed)
        setupBackgroundView(view: toppingBackgroundView, backgroundColor: .systemGray5)
        
        setupView()
        
        sizeTitleLabel = createTitleLabel(text: "容量選擇")
        sweetnessTitleLabel = createTitleLabel(text: "甜度選擇")
        temperatureTitleLabel = createTitleLabel(text: "冰量選擇")
        toppingTitleLabel = createTitleLabel(text: "加料選擇")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getToppingBackgroundViewMaxY() -> CGFloat {
        layoutIfNeeded()
        return toppingBackgroundView.frame.maxY
    }
    
    public func layoutCell(drinkInfo: Record, size: [Item], temperature: [Item], sweetness: [Item], toppings: [Item]) {
        let drinkInfo = drinkInfo.fields
        self.nameLabel.text = drinkInfo.name
        self.priceLabel.text = "$\(drinkInfo.medium)"
        self.subtiltleLabel.text = drinkInfo.description
        drinkImageView.fetchImage(url: drinkInfo.image[0].url)
        sizeButtons = createButtons(items: size, style: .circleView, action: #selector(handleSizeButton))
        temperatureButtons = createButtons(items: temperature, style: .circleView, action: #selector(handleIceButton))
        sweetnessButtons = createButtons(items: sweetness, style: .circleView, action: #selector(handleSweetnessButton))
        toppingButtons = createButtons(items: toppings, style: .roundedView, action: #selector(handleToppingButton))
        setupLayout()
    }
    
    @objc private func handleSizeButton(_ sender: SelectionButton) {
        delegate?.didTapSizeButton(sender, buttons: sizeButtons, background: sizeBackgroundView)
    }
    
    @objc private func handleIceButton(_ sender: SelectionButton) {
        delegate?.didTapIceButton(sender, buttons: temperatureButtons, background: temperatureBackgroundView)
    }
    
    @objc private func handleSweetnessButton(_ sender: SelectionButton) {
        delegate?.didTapSweetnessButton(sender, buttons: sweetnessButtons, background: sweetnessBackgroundView)
    }
    
    @objc private func handleToppingButton(_ sender: SelectionButton) {
        delegate?.didTapToppingButton(sender, buttons: toppingButtons, background: toppingBackgroundView)
    }
    
    private func createButtons(items: [Item], style: SelectionButton.ButtonStyle, action: Selector) -> [SelectionButton] {
        var buttons: [SelectionButton] = []
        for item in items {
            let button = SelectionButton()
            button.setTitle(item.name, priceTitle: item.price, buttonStyle: style)
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
    
    private func setupBackgroundView(view: UIView, backgroundColor: UIColor) {
        view.backgroundColor = backgroundColor
        view.cornerRadii(radii: 10)
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
        backgroundColor = .kebukeYellow
    }
    
    private func setupLayout() {
        setupSizeLayout()
        setupTemperatureLayout()
        setupSweetnessLayout()
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
    
    private func setupSizeLayout() {
        
        let stackView =  UIStackView(arrangedSubviews: sizeButtons)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        contentView.addSubview(stackView)
        
        sizeBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(subtiltleLabel.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(stackView.snp.bottom).offset(30)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(sizeTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
        
        sizeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sizeBackgroundView.snp.top).offset(10)
            make.leading.equalTo(sizeBackgroundView).offset(20)
            make.trailing.equalTo(sizeBackgroundView).offset(-30)
            make.height.equalTo(30)
        }
    }
    
    private func setupTemperatureLayout() {
        
        let stackView =  UIStackView(arrangedSubviews: temperatureButtons)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        contentView.addSubview(stackView)
        
        temperatureBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(sweetnessBackgroundView.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(stackView.snp.bottom).offset(30)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(temperatureTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
        
        temperatureTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureBackgroundView.snp.top).offset(10)
            make.leading.equalTo(temperatureBackgroundView).offset(20)
            make.trailing.equalTo(temperatureBackgroundView).offset(-30)
            make.height.equalTo(30)
        }
    }
    
    private func setupSweetnessLayout() {
        
        let stackView =  UIStackView(arrangedSubviews: sweetnessButtons)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        contentView.addSubview(stackView)
        
        sweetnessBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(sizeBackgroundView.snp.bottom).offset(20)
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
            make.top.equalTo(sweetnessBackgroundView.snp.top).offset(10)
            make.leading.equalTo(sweetnessBackgroundView).offset(20)
            make.trailing.equalTo(sweetnessBackgroundView).offset(-30)
            make.height.equalTo(30)
        }
    }
    
    private func setupToppingsLayout() {
        
        let stackView =  UIStackView(arrangedSubviews: toppingButtons)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        contentView.addSubview(stackView)
        
        toppingBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(temperatureBackgroundView.snp.bottom).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.leading.equalTo(self).offset(20)
            make.bottom.equalTo(stackView.snp.bottom).offset(30)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(toppingTitleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
        
        toppingTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(toppingBackgroundView.snp.top).offset(10)
            make.leading.equalTo(toppingBackgroundView).offset(20)
            make.trailing.equalTo(toppingBackgroundView).offset(-30)
            make.height.equalTo(30)
        }
        
    }
    


}
