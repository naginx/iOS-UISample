import Quick
import Nimble
@testable import iOS_UISample


final class CounterViewControllerSpec: QuickSpec {

    @MainActor
    override func spec() {
        var vc: CounterViewController!
        beforeEach {
            vc = CounterViewController()
            vc.loadViewIfNeeded()
        }

        describe("初期表示") {
            it("カウントが0であること") {
                expect(vc.countLabel.text).to(equal("0"))
            }

            it("「-」ボタンが非活性であること") {
                expect(vc.decrementButton.isEnabled).to(beFalse())
            }
        }

        describe("+ボタンをタップ") {
            context("現在値が0") {
                it("カウンタが1に増えること") {
                    vc.incrementButton.tap()
                    expect(vc.countLabel.text).to(equal("1"))
                }

                it("下限値でなくなるので「-」ボタンが活性になること") {
                    vc.incrementButton.tap()
                    expect(vc.decrementButton.isEnabled).to(beTrue())
                }

                it("-ボタンが非活性であること") {
                    expect(vc.decrementButton.isEnabled).to(beFalse())
                }
            }

            context("上限値に達した場合") {
                beforeEach {
                    vc.incrementButton.tap(repeat: 10)
                }

                it("上限値なので「+」ボタンが非活性になること") {
                    expect(vc.countLabel.text).to(equal("10"))
                    expect(vc.incrementButton.isEnabled).to(beFalse())
                }
            }
        }

        describe("-ボタンをタップ") {
            context("現在値が1") {
                beforeEach {
                    vc.incrementButton.tap()
                }

                it("カウンタが0に減ること") {
                    vc.decrementButton.tap()
                    expect(vc.countLabel.text).to(equal("0"))
                }

                it("下限値になるので「-」ボタンが非活性になること") {
                    vc.decrementButton.tap()
                    expect(vc.decrementButton.isEnabled).to(beFalse())
                }
            }

            context("現在地が「10」(上限値)") {
                beforeEach {
                    vc.incrementButton.tap(repeat: 10)
                    vc.decrementButton.tap()
                }
                it("カウンタが「9」に減ること") {
                    expect(vc.countLabel.text).to(equal("9"))
                }
                it("上限値でなくなるので「+」ボタンが非活性になること") {
                    expect(vc.incrementButton.isEnabled).to(beTrue())
                }
            }
        }
    }
}
