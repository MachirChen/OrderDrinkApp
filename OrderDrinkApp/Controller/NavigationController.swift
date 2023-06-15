//
//  NavigationController.swift
//  OrderDrinkApp
//
//  Created by Machir on 2023/6/8.
//

import UIKit

class NavigationController: UINavigationController {
    
    let appearance = UINavigationBarAppearance()

    override func viewDidLoad() {
        super.viewDidLoad()
        
                UINavigationBar.appearance().tintColor = .white
                UINavigationBar.appearance().prefersLargeTitles = true
                UINavigationBar.appearance().barTintColor = .kebukeBlue
                
                if #available(iOS 13.0, *) {
                    let appearance = UINavigationBarAppearance()
                    UINavigationBar.appearance().tintColor = .white
                    appearance.backgroundColor = .kebukeBlue
                    appearance.largeTitleTextAttributes = [.foregroundColor : UIColor.white] //portrait title
                    appearance.titleTextAttributes = [.foregroundColor : UIColor.white] //landscape title

                    UINavigationBar.appearance().tintColor = .white
                    UINavigationBar.appearance().standardAppearance = appearance //landscape
                    UINavigationBar.appearance().compactAppearance = appearance
                    UINavigationBar.appearance().scrollEdgeAppearance = appearance //portrait
                } else {
        
                    UINavigationBar.appearance().isTranslucent = false
                    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
                    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                }
        
        }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
