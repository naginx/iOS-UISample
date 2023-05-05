import Quick
import Nimble
@testable import iOS_UISample


final class CounterSpec: QuickSpec {

    override func spec() {
        describe("#init") {
            context("countが「0」であること") {
                expect(Counter().count).to(equal(0))
            }

            context("引数「5」であること") {
                expect(Counter(count: 5).count).to(equal(5))
            }
        }

        describe("#increment / #decrement") {
            context("現在値が「5」") {
                var counter: Counter!

                beforeEach {
                    counter = Counter(count: 5)
                }
                it("incrementすると6になること") {
                    counter.increment()
                    expect(counter.count).to(equal(6))
                }
                it("decrementすると4になること") {
                    counter.decrement()
                    expect(counter.count).to(equal(4))
                }
            }
        }

        describe("#isLowerLimit") {
            context("現在値が「0」") {
                it("trueを返すこと") {
                    expect(Counter().isLowerLimit).to(beTrue())
                }
            }
            context("現在値が「1」") {
                it("falseを返すこと") {
                    expect(Counter(count: 9).isUpperLimit).to(beFalse())
                }
            }
        }

        describe("#isUpperLimit") {
            context("現在値が「10」") {
                it("trueを返すこと") {
                    expect(Counter(count: 10).isUpperLimit).to(beTrue())
                }
            }
            context("現在値が「10」未満") {
                it("falseを返すこと") {
                    expect(Counter(count: 9).isUpperLimit).to(beFalse())
                }
            }
        }

        describe("永続化") {
            context("現在値が「2」") {
                var counter: Counter!
                var counterStorageMock: CounterStorageMock!

                beforeEach {
                    counterStorageMock = CounterStorageMock()
                    counter = Counter(count: 2, counterStorage: counterStorageMock)
                }

                context("#incrementを呼び出す") {
                    it("CounterStorage.save()が引数「3」で呼び出されること") {
                        counter.increment()
                        expect(counterStorageMock.latestSaveCount).to(equal(3))
                    }
                }

                context("#decrementを呼び出す") {
                    it("CounterStorage.save()が引数「1」で呼び出されること") {
                        counter.decrement()
                        expect(counterStorageMock.latestSaveCount).to(equal(1))
                    }
                }
            }
        }
    }
}
