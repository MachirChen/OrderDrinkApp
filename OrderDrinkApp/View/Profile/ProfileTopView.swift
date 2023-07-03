//
//  ProfileTopView.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/27.
//

import UIKit
import SnapKit

protocol ProfileTopViewDelegate: AnyObject {
    func didTapSettingButton()
}

class ProfileTopView: UIView {
    
    weak var delegate: ProfileTopViewDelegate?
    
    private let userImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.tintColor = .white
        return imageview
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.text = "無"
        label.textColor = .white
        return label
    }()
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    public func updateProfileTopView(with account: Account) {
        name.text = account.name
        if let image = account.image {
            userImageView.fetchImage(url: image)
            userImageView.cornerRadii(radii: 25)
        } else {
            userImageView.image = UIImage(systemName: "person.circle")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .kebukeBlue
        setupLayout()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonActions() {
        settingButton.addTarget(self, action: #selector(tapSettingButton), for: .touchUpInside)
    }
    
    @objc private func tapSettingButton() {
        delegate?.didTapSettingButton()
    }
    
    private func setupLayout() {
        addSubview(userImageView)
        addSubview(name)
        addSubview(settingButton)
        userImageView.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.leading.equalTo(self).offset(20)
            make.top.equalTo(self).offset(70)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(userImageView)
            make.leading.equalTo(userImageView.snp.trailing).offset(15)
            make.trailing.equalTo(self)
            make.height.equalTo(25)
        }
        
        settingButton.snp.makeConstraints { make in
            make.bottom.equalTo(userImageView.snp.top)
            make.height.width.equalTo(30)
            make.trailing.equalTo(self).offset(-20)
        }
    }
    
}
