//
//  ShoppingCartViewController.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/16.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    
    var orderList:[OrderResponse.Record] = []
    
    private var collectionView: UICollectionView!
    
//    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchData()
        navigationItem.title = "購物車"
    }
    
    private func generateLayout() -> UICollectionViewLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        listConfiguration.backgroundColor = .kebukeBlue
        listConfiguration.trailingSwipeActionsConfigurationProvider = {
            [weak self] indexPath in guard let self = self else { return UISwipeActionsConfiguration() }
            
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
                let order = self.orderList[indexPath.row]
                self.orderList.remove(at: indexPath.row)
                self.collectionView.deleteItems(at: [indexPath])
                OrderRequestProvider.shared.deleteOrder(id: order.id)
            }
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
        
    }
    
    private func fetchData() {
        OrderRequestProvider.shared.fetchOrderData { result in
            switch result {
            case.success(let orderList):
                self.orderList = orderList
                self.collectionView.reloadData()
            case.failure(let error):
                print("Failed to fetch Order Data:", error)
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.alwaysBounceVertical = true
        collectionView.register(ShoppingCartCollectionViewCell.self, forCellWithReuseIdentifier: ShoppingCartCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .kebukeBlue

        view.addSubview(collectionView)
    }
}

//MARK: - CollectionViewDataSource

extension ShoppingCartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        orderList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingCartCollectionViewCell.identifier, for: indexPath) as? ShoppingCartCollectionViewCell else { return UICollectionViewCell() }
        
        let order = orderList[indexPath.item]
        cell.layoutCell(drink: order)
        cell.delegate = self
        return cell
    }
}

//MARK: - CollectionViewDelegate

extension ShoppingCartViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let drinkDetailVC = DrinkDetailViewController()
//        let menuVC = MenuViewController()
//        var menu: Record?
//        for drink in menuVC.menu {
//            if drink.fields.name == orderList[indexPath.item].fields.drink {
//                menu = drink
//            }
//        }
//        drinkDetailVC.drinkInfo = menu
//        navigationController?.pushViewController(drinkDetailVC, animated: true)
        print(indexPath)
    }
    
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        <#code#>
//    }
    
    
}

//MARK: - CollectionViewDelegateFlowLayout

extension ShoppingCartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - ShoppingCartCollectionViewCellDelegate

extension ShoppingCartViewController: ShoppingCartCollectionViewCellDelegate {
    func didTapPlusButton(in cell: ShoppingCartCollectionViewCell) {
        let indexPath = collectionView.indexPath(for: cell)
        guard let item = indexPath?.item else { return }
        orderList[item].fields.quantity += 1
        collectionView.reloadItems(at: [IndexPath(item: item, section: 0)])
        let data = OrderResponse(records: orderList)
        OrderRequestProvider.shared.updateOrder(data: data)
    }
    
    func didTapMinusButton(in cell: ShoppingCartCollectionViewCell) {
        let indexPath = collectionView.indexPath(for: cell)
        guard let item = indexPath?.item else { return }
        if orderList[item].fields.quantity == 1 {
            let alert = UIAlertController(title: "刪除商品", message: "確定要刪除這個商品嗎？", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel)
            let deleteAction = UIAlertAction(title: "刪除", style: .destructive) { _ in
                OrderRequestProvider.shared.deleteOrder(id: self.orderList[item].id)
                self.orderList.remove(at: item)
                self.collectionView.reloadData()
            }
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            present(alert, animated: true)
        } else {
            orderList[item].fields.quantity -= 1
            collectionView.reloadItems(at: [IndexPath(item: item, section: 0)])
            let data = OrderResponse(records: orderList)
            OrderRequestProvider.shared.updateOrder(data: data)
        }
    }
    
}
