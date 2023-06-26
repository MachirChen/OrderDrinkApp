//
//  MenuViewController.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/8.
//

import UIKit

class MenuViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let searchController = UISearchController(searchResultsController: nil)
    private let navShoppingCartButton = ShoppingCartButton(type: .custom)
    private var menu: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        setupCollectionView()
        setupNavigationBar()
        setupSearchController()
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        updateShoppingCartButtonAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
    
    private func fetchData() {
        MenuRequestProvider.shared.fetchMenu { result in
            switch result {
            case .success(let menu):
                self.menu = menu
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "白玉歐蕾"
        searchController.searchBar.searchTextField.backgroundColor = .white
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupCollectionView() {
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .kebukeBlue
        view.addSubview(collectionView)
    }
    
    private func setupNavigationBar() {
        navShoppingCartButton.setImage(UIImage(systemName: "cart"), for: .normal)
        navShoppingCartButton.addTarget(self, action: #selector(handleShoppingCart), for: .touchUpInside)

        let cartBarButton = UIBarButtonItem(customView: navShoppingCartButton)
        navigationItem.rightBarButtonItem = cartBarButton
    }
    
    @objc private func handleShoppingCart() {
        let shoppingCartcontroller = ShoppingCartViewController()
        shoppingCartcontroller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(shoppingCartcontroller, animated: true)
    }
    
    private func updateShoppingCartButtonAppearance() {
        OrderRequestProvider.shared.fetchOrderData { result in
            switch result {
            case .success(let orderList):
                if orderList.isEmpty {
                    self.navShoppingCartButton.unpaidLightView.backgroundColor = nil
                } else {
                    self.navShoppingCartButton.unpaidLightView.backgroundColor = .systemRed
                }
            case .failure(let error):
                print("Failed to fetch order list:", error)
            }
        }
    }

}

//MARK: - CollectionViewDataSource

extension MenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }
        let drinkData = menu[indexPath.item]
        cell.layoutCell(drinkData: drinkData)
        return cell
    }
    
}
    
//MARK: - CollectionViewDelegate
    
extension MenuViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let drinkDetailController = DrinkDetailViewController()
        drinkDetailController.hidesBottomBarWhenPushed = true
        drinkDetailController.drinkInfo = menu[indexPath.item]
        navigationController?.pushViewController(drinkDetailController, animated: true)
    }
    
}

//MARK: - CollectionViewDelegateFlowLayout
    
extension MenuViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2)-30, height: (view.frame.width / 2)+50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 15
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
}

