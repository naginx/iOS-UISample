import Foundation


// MARK: - Protocol

protocol CounterStorage {
    func save(_ count: Int)
}


// MARK: - Mock

final class CounterStorageMock: CounterStorage {
    var latestSaveCount: Int?

    func save(_ count: Int) {
        latestSaveCount = count
    }
}


// MARK: - UserDefautls

final class CounterStorageDefaults: CounterStorage {

    func save(_ count: Int) {
        UserDefaults.standard.set(count, forKey: "count")
    }
}


// MARK: - Counter

final class Counter {
    private (set) var count: Int
    private let counterStorage: CounterStorage

    init(count: Int = 0, counterStorage: CounterStorage = CounterStorageDefaults()) {
        self.count = count
        self.counterStorage = counterStorage
    }

    func increment() {
        count += 1
        counterStorage.save(count)
    }

    func decrement() {
        count -= 1
        counterStorage.save(count)
    }

    var isLowerLimit: Bool {
        count == 0
    }

    var isUpperLimit: Bool {
        count == 10
    }
}
