//
//  ProfileViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/31.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Properties

    let user: User

    // MARK: - LifeCycle

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = user.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Selectors

    // MARK: - API

    // MARK: - Helpers

}
