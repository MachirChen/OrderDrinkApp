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
    var menu: [Record] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupShoppingCartButtonInNavBar()
        setupSearchController()
        fetchData()
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
        return CGSize(width: (view.frame.width / 2)-5, height: (view.frame.width / 2)+100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
}
