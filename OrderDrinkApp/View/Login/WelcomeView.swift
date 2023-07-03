//
//  WelcomeView.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/27.
//

import UIKit
import SnapKit

protocol WelcomeViewDelegate: AnyObject {
    func didTapSignUpButton(sender: UIButton)
    func didTapSignUpLaterButton()
    func didTapSignInButton(sender: UIButton)
}

class WelcomeView: UIView {
    
    weak var delegate: WelcomeViewDelegate?
    
    private let largeTitle: UILabel = {
        let label = UILabel()
        label.text = "KEBUKE"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("註冊新帳號", for: .normal)
        button.backgroundColor = .kebukeYellow
        button.setTitleColor(UIColor.white, for: .normal)
        button.cornerRadii(radii: 5)
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("登入", for: .normal)
        button.backgroundColor = .systemGray
        button.setTitleColor(UIColor.systemGray6, for: .normal)
        button.cornerRadii(radii: 5)
        return button
    }()
    
    private let signUpLaterButton: UIButton = {
        let button = UIButton()
        button.setTitle("稍後註冊", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonActions() {
        signUpButton.addTarget(self, action: #selector(tapSignUpButton), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(tapSignInButton), for: .touchUpInside)
        signUpLaterButton.addTarget(self, action: #selector(tapSignUpLaterButton), for: .touchUpInside)
    }
    
    @objc private func tapSignUpButton() {
        delegate?.didTapSignUpButton(sender: signUpButton)
    }
    
    @objc private func tapSignInButton() {
        delegate?.didTapSignInButton(sender: signInButton)
    }
    
    @objc private func tapSignUpLaterButton() {
        delegate?.didTapSignUpLaterButton()
    }

    private func setupLayout() {
        addSubview(largeTitle)
        addSubview(signInButton)
        addSubview(signUpButton)
        addSubview(signUpLaterButton)
        
        largeTitle.snp.makeConstraints { make in
            make.centerY.equalTo(self).offset(-30)
            make.height.equalTo(50)
            make.leading.trailing.equalTo(self)
        }
        
        signUpLaterButton.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-70)
            make.centerX.equalTo(self)
            make.height.equalTo(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.bottom.equalTo(signUpLaterButton.snp.top).offset(-30)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(50)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(signInButton.snp.top).offset(-30)
            make.leading.trailing.equalTo(signInButton)
            make.height.equalTo(signInButton)
        }
        
        
    }
    
}
