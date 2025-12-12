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
        
        let app = XCUIApplication()
        app.activate()
        
        let item = app.buttons["navigation_link_tap"].firstMatch
        XCTAssert(item.waitForExistence(timeout: 5))
        item.tap()
    
        // title
        let detailTitle = app.staticTexts["item_detail_title"]
        XCTAssert(detailTitle.waitForExistence(timeout: 10))
        // price
        let detailPrice = app.staticTexts["item_detail_price"]
        XCTAssert(detailPrice.waitForExistence(timeout: 10))
        // description
        let detailDesc = app.staticTexts["item_detail_desc"]
        XCTAssert(detailDesc.waitForExistence(timeout: 10))
        // product image
        let detailImage = app.images["item_detail_image"]
        XCTAssert(detailImage.waitForExistence(timeout: 10))
        
    }

//    func testLaunchPerformance() throws {
//        // This measures how long it takes to launch your application.
//        measure(metrics: [XCTApplicationLaunchMetric()]) {
//            XCUIApplication().launch()
//        }
//    }
}
