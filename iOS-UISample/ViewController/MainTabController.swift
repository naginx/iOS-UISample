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
        let tableVC = ReverseTableViewController()
        let nav1 = templateNavigationController(image: UIImage.named("home_unselected"),
                                                rootViewController: tableVC)

        let collectionVC = UserListViewController()
        let nav2 = templateNavigationController(image: UIImage.named("search_unselected"),
                                                rootViewController: collectionVC)
        let chatVC = ChatViewController()
        let nav3 = templateNavigationController(image: UIImage.named("comment"),
                                                rootViewController: chatVC)
        viewControllers = [nav1, nav2, nav3]
    }

    private func templateNavigationController(image: UIImage,
                                              rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
}
