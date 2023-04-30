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
        }

        describe("+ボタンをタップ") {
            context("現在値が0") {
                it("カウンタが1に増えること") {
                    vc.incrementButton.sendActions(for: .touchUpInside)
                    expect(vc.countLabel.text).to(equal("1"))
                }
            }
        }

    }
}
