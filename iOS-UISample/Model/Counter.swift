import Foundation


final class Counter {
    private (set) var count: Int

    var isLowerLimit: Bool {
        count == 0
    }

    var isUpperLimit: Bool {
        count == 10
    }

    func increment() {
        count += 1
    }

    func decrement() {
        count -= 1
    }

    init(count: Int = 0) {
        self.count = count
    }
}
