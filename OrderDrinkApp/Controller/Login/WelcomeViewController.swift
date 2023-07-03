//
//  WelcomeViewController.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/27.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let welcomeView = WelcomeView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWelcomeView()
    }
    
    private func setupWelcomeView() {
        welcomeView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        welcomeView.delegate = self
        welcomeView.backgroundColor = .kebukeBlue
        view.addSubview(welcomeView)
    }

}


extension WelcomeViewController: WelcomeViewDelegate {
    
    func didTapSignUpButton(sender: UIButton) {
        initSignView(state: .signUp, title: sender.titleLabel?.text)
    }
    
    func didTapSignInButton(sender: UIButton) {
        initSignView(state: .signIn, title: sender.titleLabel?.text)
    }
    
    func didTapSignUpLaterButton() {
        dismiss(animated: true)
    }
    
    private func initSignView(state: SignPageState, title: String?) {
        let controller = SignUpAndInAccountViewController()
        controller.title = title
        controller.pageState = state
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
