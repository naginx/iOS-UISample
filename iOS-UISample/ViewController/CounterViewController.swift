//
//  CounterViewController.swift
//  iOS-UISample
//
//  Created by nagisa miura on 2023/04/30.
//

import UIKit

final class CounterViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!

    var count: Int = 0

    @IBAction private func tappedDecrementButton(_ sender: UIButton) {
        count -= 1
        updateView()
    }

    @IBAction private func tappedIncrementButton(_ sender: UIButton) {
        count += 1
        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    private func updateView() {
        countLabel.text = "\(count)"
    }
}
