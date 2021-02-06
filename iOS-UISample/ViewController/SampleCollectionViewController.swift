//
//  SampleCollectionViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2021/02/06.
//

import UIKit

final class SampleCollectionViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak private var sampleCollectionView: UICollectionView! {
        didSet {
//            sampleCollectionView.delegate = self
//            sampleCollectionView.dataSource = self
        }
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        sampleCollectionView.backgroundColor = .red
    }

    // MARK: - Helpers

}

// MARK: - UICollectionViewDelegate

//extension SampleCollectionViewController: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource

//extension SampleCollectionViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return UICollectionViewCell()
//    }
//}
