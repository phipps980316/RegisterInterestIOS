//
//  AdminLoginUITests.swift
//  RegisterInterestAppUITests
//
//  Created by Jon Phipps on 14/03/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import Foundation
import XCTest
@testable import RegisterInterestApp

//TESTED WITH IPHONE 8 SIMULATOR
class AdminLoginUITests:XCTestCase {
    
    func testValidPassword(){
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["USW Interest Form"].buttons["Admin"].tap()
        XCTAssertTrue(app.navigationBars["Admin Login"].exists)
        
        let elementsQuery = app.scrollViews.otherElements
        
        let passwordField = elementsQuery.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText("abc123")

        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.navigationBars["Existing Records"].exists)
        app.terminate()
    }
    
    func testInvalidPassword(){
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["USW Interest Form"].buttons["Admin"].tap()
        XCTAssertTrue(app.navigationBars["Admin Login"].exists)
        
        let elementsQuery = app.scrollViews.otherElements
        
        let passwordField = elementsQuery.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText("abc")
        
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Information"].scrollViews.otherElements.buttons["OK"].tap()
        XCTAssertFalse(app.navigationBars["Existing Records"].exists)
        app.terminate()
    }
    
    func testBackButton(){
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["USW Interest Form"].buttons["Admin"].tap()
        XCTAssertTrue(app.navigationBars["Admin Login"].exists)
        app.navigationBars["Admin Login"].buttons["Back"].tap()
        XCTAssertTrue(app.navigationBars["USW Interest Form"].exists)
        app.terminate()
    }
}
