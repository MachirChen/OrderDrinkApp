//
//  TabBarViewController.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/8.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let menuController = MenuViewController()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        //let navController = UINavigationController(rootViewController: menuController)
        //menuController.tabBarItem.image = UIImage(systemName: "menucard")
        //menuController.tabBarItem.title = "菜單"
        //tabBar.tintColor = .gray
        //tabBar.backgroundColor = .black
        setUpChildViewControllers()
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .kebukeBlue
        tabBar.standardAppearance = appearance
    }
    
    private func setUpChildViewControllers() {
        addChildViewController(childController: MenuViewController(), title: "訂購")
    }
    
    
    private func addChildViewController(childController: UIViewController, title: String) {
        childController.title = title
//        childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(red: 176.0/255.0, green: 196.0/255.0, blue: 222.0/255.0, alpha: 1)], for: .selected)
        childController.tabBarItem.image = UIImage(systemName: "menucard")
        //childController.tabBarItem.selectedImage = UIImage.init(named: seletedImage)
        let navigationController = NavigationController.init(rootViewController: childController)
        //navigationController.navigationBar.barTintColor = .white
//        tabBar.isTranslucent = false
//        tabBar.barTintColor = .kebukeBlue
//        UITabBar.appearance().barTintColor = .kebukeBlue
        //tabBar.backgroundColor = .kebukeBlue
        self.addChild(navigationController)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
