//
//  ItemDetailUITest.swift
//  UITest
//
//  Created by saboor on 08/12/2025.
//

import XCTest

final class ItemDetailUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testItemDetailUI() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let element = app.buttons["navigation_link_tap"].firstMatch
        XCTAssertTrue(element.waitForExistence(timeout: 10))
        element.tap()
    
        let detail =  app.otherElements["item_detail_view"].firstMatch
        XCTAssertTrue(detail.waitForExistence(timeout: 15))

        let title = detail.staticTexts.firstMatch
        print(title)

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
