//
//  DrinkDetailViewController.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/9.
//

import UIKit
import SnapKit

class DrinkDetailViewController: UIViewController {
    
    var drinkInfo: Record!
    var selectedSize: String?
    var selectedtemperature: String?
    var selectedsweetness: String?
    var selectedTopping: [String] = []
    var quantity = 1
    var selectedSizePrice: Int?
    var customItem = CustomItem()
    
    private let layout = UICollectionViewFlowLayout()
    private var drinkDetailCollectionView: UICollectionView?
    private let bottomView = DrinkDetailBottomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBottomView()
        setupDrinkSizePrice()
        self.navigationItem.title = "KEBUKE"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        drinkDetailCollectionView?.collectionViewLayout.invalidateLayout()
    }
    
    private func setupCollectionView() {
        layout.itemSize = CGSize(width: view.frame.width, height: 2000)
        layout.scrollDirection = .vertical
        drinkDetailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = drinkDetailCollectionView else { return }
        collectionView.register(DrinkDetailCollectionViewCell.self, forCellWithReuseIdentifier: DrinkDetailCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .kebukeBlue
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }
    
    private func setupBottomView() {
        let bottomControlViewY = view.bounds.height - 90
        bottomView.frame = CGRect(x: 0, y: bottomControlViewY, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(bottomView)
        print(bottomView.frame.size)
        print(bottomView.bounds.size)
        print(bottomView.frame.origin)
        print(self.view.frame.size)
        print(bottomView.frame.minY)
        bottomView.delegate = self
    }
    
    private func setupCollectionViewLayoutItemSize(maxY: CGFloat) {
        layout.itemSize.height = 100 + maxY
    }
    
    private func setupDrinkSizePrice() {
        guard let largePrice = drinkInfo.fields.large else {
            customItem.oneSize[0].price = "$ \(drinkInfo.fields.medium)"
            return
        }
        customItem.size[0].price = "$ \(largePrice)"
        customItem.size[1].price = "$ \(drinkInfo.fields.medium)"
    }
    
}

//MARK: - CollectionViewDataSource

extension DrinkDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let drinkInfo = drinkInfo else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkDetailCollectionViewCell.identifier, for: indexPath) as? DrinkDetailCollectionViewCell else { return UICollectionViewCell() }
        
        switch drinkInfo.fields.name {
        case "熟成檸果":
            cell.layoutCell(drinkInfo: drinkInfo, size: customItem.oneSize, temperature: customItem.nonHotTemperature, sweetness: customItem.sugarLevel, toppings: customItem.toppings)
        case "雪藏紅茶":
            cell.layoutCell(drinkInfo: drinkInfo, size: customItem.size, temperature: customItem.nonHotTemperature, sweetness: customItem.sugarLevel, toppings: customItem.toppings)
        case "冷露檸果", "冷露歐蕾":
            cell.layoutCell(drinkInfo: drinkInfo, size: customItem.size, temperature: customItem.nonHotTemperature, sweetness: customItem.twoSugarLevel, toppings: customItem.toppings)
        default:
            if drinkInfo.fields.name.hasPrefix("白玉") {
                cell.layoutCell(drinkInfo: drinkInfo, size: customItem.size, temperature: customItem.iceLevel, sweetness: customItem.sugarLevel, toppings: customItem.oneTopping)
            } else {
                cell.layoutCell(drinkInfo: drinkInfo, size: customItem.size, temperature: customItem.iceLevel, sweetness: customItem.sugarLevel, toppings: customItem.toppings)
            }
        }
        setupCollectionViewLayoutItemSize(maxY: cell.getToppingBackgroundViewMaxY())
        cell.delegate = self
        return cell
    }
    
}



//MARK: - CollectionViewDelegateFlowLayout

extension DrinkDetailViewController: UICollectionViewDelegateFlowLayout {
    
}

//MARK: - DrinkDetailBottomViewDelegate

extension DrinkDetailViewController: DrinkDetailBottomViewDelegate {
    func didTapPlusButton() {
        quantity += 1
        bottomView.updateQuantityLabel(with: quantity)
        if quantity != 1 {
            bottomView.updateMinusButtonAvailability(enabled: true)
        }
    }
    
    func didTapMinusButton() {
        quantity -= 1
        bottomView.updateQuantityLabel(with: quantity)
        if quantity == 1 {
            bottomView.updateMinusButtonAvailability(enabled: false)
        }
    }
    
    func didTapOrderButton() {
        guard let temperature = selectedtemperature, let sweetness = selectedsweetness, let price = selectedSizePrice else { return }
        let drinkName = drinkInfo.fields.name
        let imageURL = drinkInfo.fields.image[0].url
        var toppingsString = ""
        for (index, topping) in selectedTopping.enumerated() {
            toppingsString += topping
            if index < selectedTopping.count - 1 {
                toppingsString += ", "
            }
        }
        let orderData = Order(records: [.init(fields: .init(drink: drinkName, temperature: temperature, sweetness: sweetness, toppings: toppingsString, quantity: quantity, price: price, image: [.init(url: imageURL)]))])
        OrderRequestProvider.shared.uploadDrink(data: orderData)
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - DrinkDetailCollectionViewCellDelegate

extension DrinkDetailViewController: DrinkDetailCollectionViewCellDelegate {
    
    func didTapIceButton(_ sender: SelectionButton, buttons: [SelectionButton], background: UIView) {
        changeSelected(button: sender, in: buttons)
        changeColorToGray(background)
        selectedtemperature = sender.title.text
        OrderButtonIsEnable()
    }
    
    func didTapSweetnessButton(_ sender: SelectionButton, buttons: [SelectionButton], background: UIView) {
        changeSelected(button: sender, in: buttons)
        changeColorToGray(background)
        selectedsweetness = sender.title.text
        OrderButtonIsEnable()
    }
    
    func didTapSizeButton(_ sender: SelectionButton, buttons: [SelectionButton], background: UIView) {
        changeSelected(button: sender, in: buttons)
        changeColorToGray(background)
        selectedSize = sender.title.text
        if sender.title.text == "中杯" {
            selectedSizePrice = drinkInfo.fields.medium
        } else {
            guard let largePrice = drinkInfo.fields.large else { return }
            selectedSizePrice = largePrice
        }
        OrderButtonIsEnable()
    }
    
    func didTapToppingButton(_ sender: SelectionButton, buttons: [SelectionButton], background: UIView) {
        sender.isChecked = !sender.isChecked
        selectedTopping.removeAll()
        updateSelectedButtons(in: buttons)
    }
    
    private func updateSelectedButtons(in buttons: [SelectionButton]) {
        for button in buttons {
            if button.isChecked {
                guard let topping = button.title.text else { return }
                selectedTopping.append(topping)
            }
        }
    }
    
    private func OrderButtonIsEnable() {
        if selectedSize != nil, selectedsweetness != nil, selectedtemperature != nil {
            bottomView.enableOrderButton()
        }
    }
    
    private func changeColorToGray(_ view: UIView) {
        UIView.animate(withDuration: 2.0) {
            view.backgroundColor = .systemGray5
        }
    }
    
    private func changeSelected(button sender: SelectionButton, in buttons: [SelectionButton]) {
        for button in buttons {
            button.isChecked = (button == sender)
        }
    }
}
