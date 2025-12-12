//
//  ItemDetailUITest.swift
//  UITest
//
//  Created by saboor on 08/12/2025.
//

import XCTest

final class ItemDetailUITest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
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

}
