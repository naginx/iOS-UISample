import XCTest
@testable import iOS_UISample


// UIテストを後からプロジェクトに追加する場合、
// File -> New -> Target から UI Testing Bundle を選択して作成すること
final class iOS_UISampleUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {

    }

    func testExample() {
        let table = app.tables
        XCTAssertEqual(table.cells.count, 4)
    }
}
