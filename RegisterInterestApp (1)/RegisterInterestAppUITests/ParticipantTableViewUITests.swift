//
//  ParticipantTableViewUITests.swift
//  RegisterInterestAppUITests
//
//  Created by Jon Phipps on 14/03/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import Foundation
import XCTest
@testable import RegisterInterestApp

//TESTED WITH IPHONE 8 SIMULATOR
class ParticipantTableViewUITests:XCTestCase{
    
    func testSelectingRecord(){
        let app = XCUIApplication()
        app.launch()
        let scrollViewsQuery = app.scrollViews
        let element = scrollViewsQuery.children(matching: .other).element(boundBy: 0)

        let firstNameField = element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).children(matching: .textField).element
        firstNameField.tap()
        firstNameField.typeText("Jon")
        
        let surnameField = app.scrollViews.containing(.textField, identifier:"Jon").children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        surnameField.tap()
        surnameField.typeText("Phipps")
        
        let emailField = app.scrollViews.containing(.textField, identifier:"Phipps").children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 2).children(matching: .textField).element
        emailField.tap()
        emailField.typeText("jon@gmail.com")
        
        app/*@START_MENU_TOKEN@*/.scrollViews.containing(.other, identifier:"Vertical scroll bar, 2 pages")/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\")",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 2 pages\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 0).tap()
        element.swipeUp()
        
        var elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.datePickers/*@START_MENU_TOKEN@*/.pickerWheels["2020"]/*[[".pickers.pickerWheels[\"2020\"]",".pickerWheels[\"2020\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        elementsQuery.buttons["Submit"].tap()
        sleep(10)
        app.alerts["Information"].scrollViews.otherElements.buttons["OK"].tap()
        app.navigationBars["Confirmation"].buttons["Done"].tap()
        XCTAssertTrue(app.navigationBars["USW Interest Form"].exists)
        
        app.terminate()
        app.launch()
        
        app.navigationBars["USW Interest Form"].buttons["Admin"].tap()
        XCTAssertTrue(app.navigationBars["Admin Login"].exists)
        
        elementsQuery = app.scrollViews.otherElements
        
        let passwordField = elementsQuery.secureTextFields["Password"]
        passwordField.tap()
        passwordField.typeText("abc123")

        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.navigationBars["Existing Records"].exists)
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Name: Jon Phipps"]/*[[".cells.staticTexts[\"Name: Jon Phipps\"]",".staticTexts[\"Name: Jon Phipps\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        XCTAssertTrue(app.navigationBars["Record"].exists)
        app.terminate()
    }
    
    func testBackButton(){
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
        app.navigationBars["Existing Records"].buttons["Back"].tap()
        XCTAssertTrue(app.navigationBars["Admin Login"].exists)
        app.terminate()
    }
}
