//
//  SignUpAccountViewController.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/27.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import Firebase

enum SignPageState {
    case signUp
    case signIn
}

class SignUpAndInAccountViewController: UIViewController {
    
    let signUpAndInAccountView = SignUpAndInAccountView()
    
    var email = String()
    var password = String()
    var pageState: SignPageState?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignUpAndInAccountView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    private func setupSignUpAndInAccountView() {
        guard let pageState = pageState else { return }
        switch pageState {
        case .signIn:
            signUpAndInAccountView.updateSignInView()
        case .signUp:
            signUpAndInAccountView.updateSignUpView()
        }
        signUpAndInAccountView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        signUpAndInAccountView.delegate = self
        signUpAndInAccountView.emailTextField.delegate = self
        signUpAndInAccountView.passwordTextField.delegate = self
        view.addSubview(signUpAndInAccountView)
    }
}

extension SignUpAndInAccountViewController: SignUpAndInAccountViewDelegate {

    func didTapSignUpButton() {
        guard let pageState = pageState else { return }
        switch pageState {
        case .signUp:
            UserRequestProvider.shared.signUp(withEmail: email, withPassword: password) { result in
                switch result {
                case .success:
                    self.dismiss(animated: true)
                case .failure(_):
                    self.showAlert(title: "此電子信箱已被使用", message: "你可能已經用此電子信箱註冊過囉")
                }
            }
        case .signIn:
            UserRequestProvider.shared.signIn(withEmail: email, withPassword: password) { result in
                switch result {
                case .success:
                    self.dismiss(animated: true)
                case .failure(_):
                    self.showAlert(title: "登入失敗", message: "找不到此會員資料，請確認帳號是否輸入正確")
                }
            }
        }
    }
    
//    func didTapGoogleSignUpButton() {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] result, error in
//            print("無")
//            guard let idToken = result?.authentication.idToken, let accessToken = result?.authentication.accessToken else { return }
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//            Auth.auth().signIn(with: credential)
//            self.dismiss(animated: true)
//        }
//    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "好", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
}

extension SignUpAndInAccountViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text, let textRange = Range(range, in: text) else { return true }
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        if textField == signUpAndInAccountView.emailTextField {
            email = updatedText
        } else if textField == signUpAndInAccountView.passwordTextField {
            password = updatedText
        }
        
        if isValidEmail(email) && password.count > 5 {
            signUpAndInAccountView.updateSignUpButtonAvailability(enabled: true)
        } else {
            signUpAndInAccountView.updateSignUpButtonAvailability(enabled: false)
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
