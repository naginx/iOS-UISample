//
//  CounterViewControllerTests.swift
//  iOS-UISampleTests
//
//  Created by nagisa miura on 2023/04/30.
//

import XCTest
@testable import iOS_UISample

final class CounterViewControllerTests: XCTestCase {

    // xibで作成したViewControllerをUnitテストでテストするための実装
    var sut: CounterViewController!
    override func setUpWithError() throws {
        sut = CounterViewController()
        sut.loadViewIfNeeded()
    }

    func testIncrementButton() {
        XCTAssertEqual(sut.countLabel.text, "0")

        sut.incrementButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(sut.countLabel.text, "1")
    }
}
