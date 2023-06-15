//
//  DrinkDetailViewController.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/9.
//

import UIKit
import SnapKit

class DrinkDetailViewController: UIViewController {
    
    var drinkSize: String!
    
    var drinkInfo: Record?
    let size = Size.allCases.map { $0.rawValue }
    let temperature = IceLevel.allCases.map { $0.rawValue }
    let sweetness = SugarLevel.allCases.map { $0.rawValue }
    let toppings = Toppings.allCases.map { $0.rawValue }
    let nonHotTemperature = ["去冰", "微冰", "少冰", "正常冰"]
    let agarPearl = ["水玉"]
    let agarPearlPrice = ["+$ 10"]
    let toppingsPrice = ["+$ 10", "+$ 10"]
    
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let bottomView = DrinkDetailBottomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBottomView()
        self.navigationItem.title = "KEBUKE"

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupCollectionViewLayout()
        setupBottomViewLayout()
    }
    
    private func setupCollectionView() {
        collectionView.register(DrinkDetailCollectionViewCell.self, forCellWithReuseIdentifier: DrinkDetailCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .kebukeBlue
        view.addSubview(collectionView)
    }
    
    private func setupCollectionViewLayout() {
        collectionView.frame = view.bounds
    }
    
    private func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.delegate = self
    }
    
    private func setupBottomViewLayout() {
        let bottomControlViewY = view.bounds.height - 90
        bottomView.frame = CGRect(x: 0, y: bottomControlViewY, width: view.bounds.width, height: view.bounds.height)
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
        

        let mediumPrice = ["\(drinkInfo.fields.medium)"]
        let mediumSize = ["中杯"]
        
        switch drinkInfo.fields.name {
        case "熟成檸果":
            cell.layoutCell(drinkInfo: drinkInfo, capacitySize: mediumSize, temperature: nonHotTemperature, sweetness: sweetness, toppings: toppings, sizePrice: mediumPrice, toppingsPrice: toppingsPrice)
        case "雪藏紅茶":
            guard let largePrice = drinkInfo.fields.large else { return UICollectionViewCell() }
            let price = ["\(largePrice)", "\(drinkInfo.fields.medium)"]
            cell.layoutCell(drinkInfo: drinkInfo, capacitySize: size, temperature: nonHotTemperature, sweetness: sweetness, toppings: toppings, sizePrice: price, toppingsPrice: toppingsPrice)
        case "冷露檸果":
            guard let largePrice = drinkInfo.fields.large else { return UICollectionViewCell() }
            let price = ["\(largePrice)", "\(drinkInfo.fields.medium)"]
            cell.layoutCell(drinkInfo: drinkInfo, capacitySize: size, temperature: nonHotTemperature, sweetness: sweetness, toppings: toppings, sizePrice: price, toppingsPrice: toppingsPrice)
        default:
            guard let largePrice = drinkInfo.fields.large else { return UICollectionViewCell() }
            let price = ["\(largePrice)", "\(drinkInfo.fields.medium)"]
            if drinkInfo.fields.name.hasPrefix("白玉") {
                cell.layoutCell(drinkInfo: drinkInfo, capacitySize: size, temperature: temperature, sweetness: sweetness, toppings: agarPearl, sizePrice: price, toppingsPrice: agarPearlPrice)
            } else {
                cell.layoutCell(drinkInfo: drinkInfo, capacitySize: size, temperature: temperature, sweetness: sweetness, toppings: toppings, sizePrice: price, toppingsPrice: toppingsPrice)
            }
        }
        
        return cell
    }
    
}

//MARK: - CollectionViewDelegateFlowLayout

extension DrinkDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 3000)
    }
}

//MARK: - DrinkDetailBottomViewDelegate

extension DrinkDetailViewController: DrinkDetailBottomViewDelegate {
    
    func didTapOrderButton(_ view: DrinkDetailBottomView) {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapMinusButton(_ view: DrinkDetailBottomView) {

    }
    
    func didTapPlusButton(_ view: DrinkDetailBottomView) {

    }
    
}
