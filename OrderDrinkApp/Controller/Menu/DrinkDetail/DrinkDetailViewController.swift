//
//  DrinkDetailViewController.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/9.
//

import UIKit
import SnapKit

class DrinkDetailViewController: UIViewController {
    
    var drinkInfo: Record?
    var selectedSize: String?
    var selectedtemperature: String?
    var selectedsweetness: String?
    var selectedTopping: [String] = []
    var quantity = 1
    var selectedSizePrice: Int?
    var customItem = CustomItem()
    var shouldUpdateHeight = false
    var cellHeight:CGFloat = 2000
    
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let bottomView = DrinkDetailBottomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBottomView()
        self.navigationItem.title = "KEBUKE"
        let notificationName = Notification.Name("backViewFrameHeight")
        NotificationCenter.default.addObserver(self, selector: #selector(changeCellSize), name: notificationName, object: nil)
    }
    
    @objc private func changeCellSize(noti: Notification) {
        if let userInfo = noti.userInfo {
            let maxY = userInfo["toppingsBackgroundViewMaxY"]
            print(maxY)
            self.cellHeight = maxY as! CGFloat + 80
            self.shouldUpdateHeight = true
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    private func setupCollectionView() {
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
        bottomView.delegate = self
    }
    
}

//MARK: - CollectionViewDataSource

extension DrinkDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let drinkInfo = drinkInfo else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrinkDetailCollectionViewCell.identifier, for: indexPath) as? DrinkDetailCollectionViewCell else { return UICollectionViewCell() }
        
        
        switch drinkInfo.fields.name {
        case "熟成檸果":
            customItem.oneSize[0].price = "$ \(drinkInfo.fields.medium)"
            cell.layoutCell(drinkInfo: drinkInfo, size: customItem.oneSize, temperature: customItem.nonHotTemperature, sweetness: customItem.sugarLevel, toppings: customItem.toppings)
        case "雪藏紅茶":
            guard let largePrice = drinkInfo.fields.large else { return UICollectionViewCell() }
            customItem.size[0].price = "$ \(largePrice)"
            customItem.size[1].price = "$ \(drinkInfo.fields.medium)"
            cell.layoutCell(drinkInfo: drinkInfo, size: customItem.size, temperature: customItem.nonHotTemperature, sweetness: customItem.sugarLevel, toppings: customItem.toppings)
        case "冷露檸果":
            guard let largePrice = drinkInfo.fields.large else { return UICollectionViewCell() }
            customItem.size[0].price = "$ \(largePrice)"
            customItem.size[1].price = "$ \(drinkInfo.fields.medium)"
            cell.layoutCell(drinkInfo: drinkInfo, size: customItem.size, temperature: customItem.nonHotTemperature, sweetness: customItem.twoSugarLevel, toppings: customItem.toppings)
        case "冷露歐蕾":
            guard let largePrice = drinkInfo.fields.large else { return UICollectionViewCell() }
            customItem.size[0].price = "$ \(largePrice)"
            customItem.size[1].price = "$ \(drinkInfo.fields.medium)"
            cell.layoutCell(drinkInfo: drinkInfo, size: customItem.size, temperature: customItem.nonHotTemperature, sweetness: customItem.twoSugarLevel, toppings: customItem.toppings)
        default:
            guard let largePrice = drinkInfo.fields.large else { return UICollectionViewCell() }
            customItem.size[0].price = "$ \(largePrice)"
            customItem.size[1].price = "$ \(drinkInfo.fields.medium)"
            if drinkInfo.fields.name.hasPrefix("白玉") {
                cell.layoutCell(drinkInfo: drinkInfo, size: customItem.size, temperature: customItem.iceLevel, sweetness: customItem.sugarLevel, toppings: customItem.oneTopping)
            } else {
                cell.layoutCell(drinkInfo: drinkInfo, size: customItem.size, temperature: customItem.iceLevel, sweetness: customItem.sugarLevel, toppings: customItem.toppings)
            }
        }
        cell.delegate = self
        return cell
    }
    
}

//MARK: - CollectionViewDelegateFlowLayout

extension DrinkDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //監聽尺寸開始
        print("cell尺寸")
        let defaultHeight: CGFloat = 2000
        let updatedHeight: CGFloat = 1608//加230
        
        if shouldUpdateHeight {
            return CGSize(width: collectionView.frame.width, height: cellHeight)
        } else {
            return CGSize(width: collectionView.frame.width, height: cellHeight)
        }
    }
}

//MARK: - DrinkDetailBottomViewDelegate

extension DrinkDetailViewController: DrinkDetailBottomViewDelegate {
    func didTapMinusButton(minusButton: UIButton, plusButton: UIButton, quantityLabel: UILabel) {
        quantity -= 1
        quantityLabel.text = "\(quantity)"
        if quantity == 1 {
            minusButton.isEnabled = false
        }
    }
    
    func didTapPlusButton(plusButton: UIButton, minusButton: UIButton, quantityLabel: UILabel) {
        quantity += 1
        quantityLabel.text = "\(quantity)"
        if quantity != 1 {
            minusButton.isEnabled = true
        }
    }
    
    func didTapOrderButton() {
        guard let drinkName = drinkInfo?.fields.name, let temperature = selectedtemperature, let sweetness = selectedsweetness, let price = selectedSizePrice, let imageURL = drinkInfo?.fields.image[0].url else { return }
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
        for button in buttons {
            button.isChecked = (button == sender)
        }
        UIView.animate(withDuration: 2.0) {
            background.backgroundColor = .systemGray5
        }
        selectedtemperature = sender.title.text
        changeButtonState()
    }
    
    func didTapSweetnessButton(_ sender: SelectionButton, buttons: [SelectionButton], background: UIView) {
        for button in buttons {
            button.isChecked = (button == sender)
        }
        UIView.animate(withDuration: 2.0) {
            background.backgroundColor = .systemGray5
        }
        selectedsweetness = sender.title.text
        changeButtonState()
    }
    
    func didTapSizeButton(_ sender: SelectionButton, buttons: [SelectionButton], background: UIView) {
        for button in buttons {
            button.isChecked = (button == sender)
        }
        UIView.animate(withDuration: 2.0) {
            background.backgroundColor = .systemGray5
        }
        selectedSize = sender.title.text
        if sender.title.text == "中杯" {
            selectedSizePrice = drinkInfo?.fields.medium
        } else {
            guard let largePrice = drinkInfo?.fields.large else { return }
            selectedSizePrice = largePrice
        }
        changeButtonState()
    }
    
//    func didTapSizeButton(_ sender: SelectionButton, buttons: [SelectionButton]) {
//        for button in buttons {
//            button.isChecked = (button == sender)
//        }
//        selectedSize = sender.title.text
//        changeButtonState()
//    }
    
//    func didTapIceButton(_ sender: SelectionButton, buttons: [SelectionButton]) {
//        for button in buttons {
//            button.isChecked = (button == sender)
//        }
//        selectedtemperature = sender.title.text
//        changeButtonState()
//    }
//
//    func didTapSweetnessButton(_ sender: SelectionButton, buttons: [SelectionButton]) {
//        for button in buttons {
//            button.isChecked = (button == sender)
//        }
//        selectedsweetness = sender.title.text
//        changeButtonState()
//    }
    
    func didTapToppingButton(_ sender: SelectionButton, buttons: [SelectionButton], background: UIView) {
        sender.isChecked = !sender.isChecked
        selectedTopping.removeAll()
        for button in buttons {
            if button.isChecked {
                guard let topping = button.title.text else { return }
                selectedTopping.append(topping)
            }
        }
        
        let notificationName = Notification.Name("backViewFrameHeight")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["toppingsBackgroundViewMaxY" : background.frame.maxY])
    }
    
    private func changeButtonState() {
        if selectedSize != nil, selectedsweetness != nil, selectedtemperature != nil {
            bottomView.orderButton.isEnabled = true
            bottomView.orderButton.backgroundColor = .kebukeYellow
        }
    }
    
}
