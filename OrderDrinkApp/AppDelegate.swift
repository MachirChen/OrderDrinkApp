//
//  AppDelegate.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/8.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        UINavigationBar.appearance().tintColor = .white
//        UINavigationBar.appearance().prefersLargeTitles = true
//        UINavigationBar.appearance().barTintColor = .red
//
//        if #available(iOS 13.0, *) {
//            let appearance = UINavigationBarAppearance()
//            UINavigationBar.appearance().tintColor = .white
//            appearance.backgroundColor = .red
//            appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white] //portrait title
//            appearance.titleTextAttributes = [.foregroundColor : UIColor.white] //landscape title
//
//            UINavigationBar.appearance().tintColor = .white
//            UINavigationBar.appearance().standardAppearance = appearance //landscape
//            UINavigationBar.appearance().compactAppearance = appearance
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance //portrait
//        } else {
//
//            UINavigationBar.appearance().isTranslucent = false
//            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
//            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        }
//
//        if #available(iOS 15.0, *) {
//            UITableView.appearance().sectionHeaderTopPadding = 0.0
//        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

