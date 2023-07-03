//
//  ProfileViewController.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/26.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var collection: UICollectionView!
    private let topView = ProfileTopView()
    private var currentUser: Account?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTopView()
    }
    
    private func setupTopView() {
        topView.delegate = self
        topView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        view.addSubview(topView)
    }
    
    private func fetchData() {
        UserRequestProvider.shared.listenFirebaseLoginSendAccount { result in
            switch result {
            case .success(let account):
                self.currentUser = account
                guard let account = account else { return }
                self.topView.updateProfileTopView(with: account)
            case .failure(let error):
                print("Failed to fetch account:", error)
            }
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        collection.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        collection.alwaysBounceVertical = true
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .kebukeBlue
        view.addSubview(collection)
    }
}

//MARK: - CollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

//MARK: - CollectionViewDelegate

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - CollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 160)
    }
}

extension ProfileViewController: ProfileTopViewDelegate {
    func didTapSettingButton() {
        showAlertActionSheet()
    }
    
    private func showAlertActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "登出帳號", style: .default) { _ in
            UserRequestProvider.shared.logOut()
            self.tabBarController?.selectedIndex = 0
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }
}
