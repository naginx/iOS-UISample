//
//  ProfileViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/01/31.
//

import UIKit

/// ペアーズ風のプロフィール画面
/// ScrollViewの参考: https://qiita.com/Masataka-n/items/c19456f172627359d0d8
final class ProfileViewController: UIViewController {

    // MARK: - Properties

    let user: User

    @IBOutlet weak private var basicProfileBaseView: UIView!

    // MARK: - LifeCycle

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = user.name
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        basicProfileBaseView.layer.cornerRadius = basicProfileBaseView.frame.height * 0.1
    }

    // MARK: - Selectors

    // MARK: - API

    // MARK: - Helpers

}
