//
//  AddProductUITest.swift
//  UITest
//
//  Created by saboor on 13/12/2025.
//

import XCTest

final class AddProductUITest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddProductUI() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // add button
        let addButton = app/*@START_MENU_TOKEN@*/.buttons["add"]/*[[".navigationBars.buttons[\"add\"]",".buttons[\"add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        XCTAssertTrue(addButton.waitForExistence(timeout: 5))
        addButton.tap()
        
        // title field
        let titleField = app.textFields["title_field"].firstMatch
        XCTAssertTrue(titleField.waitForExistence(timeout: 5))
        titleField.tap()
        titleField.typeText("iPad Pro M5")
        
        // priceField
        let priceField = app.textFields["price_field"].firstMatch
        XCTAssertTrue(priceField.waitForExistence(timeout: 5))
        priceField.tap()
        priceField.typeText("750")
        
        // priceField
        let descField = app.textFields["desc_field"].firstMatch
        XCTAssertTrue(descField.waitForExistence(timeout: 5))
        descField.tap()
        descField.typeText("dummy description goes here")
        
        
    }

}
