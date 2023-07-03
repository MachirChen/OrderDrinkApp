//
//  signUpAccountView.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/27.
//

import UIKit
import SnapKit
import GoogleSignIn

protocol SignUpAndInAccountViewDelegate: AnyObject {
//    func didTapGoogleSignUpButton()
    func didTapSignUpButton()
}

class SignUpAndInAccountView: UIView {
    
    weak var delegate: SignUpAndInAccountViewDelegate?
    
    public let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "電子信箱"
        textField.backgroundColor = .systemGray6
        textField.cornerRadii(radii: 10)
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    public let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "密碼  (6～50 個字元)"
        textField.backgroundColor = .systemGray6
        textField.cornerRadii(radii: 10)
        textField.keyboardType = .asciiCapable
        return textField
    }()
    
    private let signUpAndInButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("註冊", for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.cornerRadii(radii: 10)
        return button
    }()
    
    public func updateSignUpView() {
        passwordTextField.placeholder = "密碼  (6～50 個字元)"
        signUpAndInButton.setTitle("註冊", for: .normal)
    }
    
    public func updateSignInView() {
        passwordTextField.placeholder = "密碼"
        signUpAndInButton.setTitle("登入", for: .normal)
    }
    
    public func updateSignUpButtonAvailability(enabled: Bool) {
        signUpAndInButton.isEnabled = enabled
        if signUpAndInButton.isEnabled == true {
            signUpAndInButton.backgroundColor = .kebukeYellow
        } else {
            signUpAndInButton.backgroundColor = .gray
        }
    }
    
//    let googleSignUpButton = GIDSignInButton()

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
//        googleSignUpButton.addTarget(self, action: #selector(tapGoogleSignUpButton), for: .touchUpInside)
        signUpAndInButton.addTarget(self, action: #selector(tapSignUpButton), for: .touchUpInside)
    }
    
    @objc private func tapSignUpButton() {
        delegate?.didTapSignUpButton()
    }
    
//    @objc private func tapGoogleSignUpButton() {
//        delegate?.didTapGoogleSignUpButton()
//    }
    
    private func setupSignUpAndInButton() {
        addSubview(signUpAndInButton)
        signUpAndInButton.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(emailTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
        }
    }
    
//    private func setupGoogleSignUpButton() {
//        addSubview(googleSignUpButton)
//        googleSignUpButton.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(emailTextField)
//            make.top.equalTo(signUpAndInButton.snp.bottom).offset(30)
//        }
//    }
    
    private func setupEmailTextFieldView() {
        addSubview(emailTextField)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftView = paddingView
        emailTextField.leftViewMode = .always
        
        emailTextField.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(50)
            make.trailing.equalTo(self).offset(-50)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(50)
            make.height.equalTo(40)
        }
    }
    
    private func setupPasswordTextFieldView() {
        addSubview(passwordTextField)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        passwordTextField.leftView = paddingView
        passwordTextField.leftViewMode = .always
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.height.equalTo(emailTextField.snp.height)
        }
    }
    
    private func setupLayout() {
        setupEmailTextFieldView()
        setupPasswordTextFieldView()
        setupSignUpAndInButton()
//        setupGoogleSignUpButton()
    }
    
}
