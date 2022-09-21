//
//  TabBarController.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    func configureTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = Constants.appTintColor
        
        let mainVC = ClassifiedADSViewController()
        
        mainVC.tabBarItem = UITabBarItem(title: "Rechercher", image: SFSymbols.magnifyingGlass, tag: 0)
        let mainNC = UINavigationController(rootViewController: mainVC)
        
        if let font = UIFont(name: Constants.boldFontName, size: 30) {
            let attributes = [NSAttributedString.Key.font:font,
                              NSAttributedString.Key.foregroundColor:Constants.appTintColor]
            mainNC.navigationBar.titleTextAttributes = attributes
        }
        
        viewControllers = [mainNC]
    }
}
