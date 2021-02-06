//
//  MainTabController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/19.
//

import UIKit

final class MainTabController: UITabBarController {

    // MARK: - Properties

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }

    // MARK: - Helpers

    private func configureViewControllers() {
        let tableVC = SampleTableViewController()
        let nav1 = templateNavigationController(image: UIImage.named("home_unselected"), rootViewController: tableVC)

        viewControllers = [nav1]
    }

    private func templateNavigationController(image: UIImage,
                                              rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
}
