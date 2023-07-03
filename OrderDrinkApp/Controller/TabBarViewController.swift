//
//  TabBarViewController.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/8.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChildViewControllers()
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .kebukeBlue
        tabBar.standardAppearance = appearance
        delegate = self
    }
    
    private func setUpChildViewControllers() {
        addChildViewController(childController: MenuViewController(), title: "訂購", image: "menucard")
        addChildViewController(childController: ProfileViewController(), title: "我的", image: "line.3.horizontal")
    }
    
    
    private func addChildViewController(childController: UIViewController, title: String, image: String) {
        childController.title = title
        childController.tabBarItem.image = UIImage(systemName: image)
        let navigationController = NavigationController.init(rootViewController: childController)
        self.addChild(navigationController)
    }

}

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if UserRequestProvider.shared.currentUser == nil {
            switch viewController {
            case viewControllers?[0]:
                return true
            default:
                presentWelcomePage()
                return false
            }
        } else {
            return true
        }
    }
    
    func presentWelcomePage() {
        let controller = WelcomeViewController()
        let navController = NavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
}
