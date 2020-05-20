//
//  InterestFormUITests.swift
//  RegisterInterestAppUITests
//
//  Created by Jon Phipps on 13/03/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import Foundation
import XCTest
@testable import RegisterInterestApp

//TESTED WITH IPHONE 8 SIMULATOR
class InterestFormUITests:XCTestCase {
    
    func testNoFirstName(){
        let app = XCUIApplication()
        app.launch()
        let scrollViewsQuery = app.scrollViews
        let element = scrollViewsQuery.children(matching: .other).element(boundBy: 0)
        element.swipeUp()
        element.swipeUp()
        scrollViewsQuery.otherElements.buttons["Submit"].tap()
        XCTAssertTrue(app.alerts["Information"].exists)
        app.alerts["Information"].scrollViews.otherElements.buttons["OK"].tap()
        app.terminate()
    }
    
    func testNoSurname(){
        let app = XCUIApplication()
        app.launch()
        let scrollViewsQuery = app.scrollViews
        let element = scrollViewsQuery.children(matching: .other).element(boundBy: 0)
        
        let firstNameField = element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).children(matching: .textField).element
        firstNameField.tap()
        firstNameField.typeText("Jon")
        
        app/*@START_MENU_TOKEN@*/.scrollViews.containing(.other, identifier:"Vertical scroll bar, 2 pages")/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\")",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 2 pages\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 0).tap()
        element.swipeUp()
        scrollViewsQuery.otherElements.buttons["Submit"].tap()
        XCTAssertTrue(app.alerts["Information"].exists)
        app.alerts["Information"].scrollViews.otherElements.buttons["OK"].tap()
        app.terminate()
    }
    
    func testNoEmail(){
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

        app.scrollViews.containing(.textField, identifier:"Phipps").children(matching: .other).element(boundBy: 0).tap()
        element.swipeUp()
        scrollViewsQuery.otherElements.buttons["Submit"].tap()
        XCTAssertTrue(app.alerts["Information"].exists)
        app.alerts["Information"].scrollViews.otherElements.buttons["OK"].tap()
        app.terminate()
    }
    
    func testInvalidEmail(){
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
        emailField.typeText("abc")
        
        app/*@START_MENU_TOKEN@*/.scrollViews.containing(.other, identifier:"Vertical scroll bar, 2 pages")/*[[".scrollViews.containing(.other, identifier:\"Horizontal scroll bar, 1 page\")",".scrollViews.containing(.other, identifier:\"Vertical scroll bar, 2 pages\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .other).element(boundBy: 0).tap()
        element.swipeUp()
        element.swipeUp()
        scrollViewsQuery.otherElements.buttons["Submit"]/*@START_MENU_TOKEN@*/.press(forDuration: 0.5);/*[[".tap()",".press(forDuration: 0.5);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(app.alerts["Information"].exists)
        app.alerts["Information"].scrollViews.otherElements.buttons["OK"].tap()
        app.terminate()
    }
    
    func testInvalidDate(){
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
        element.swipeUp()
        scrollViewsQuery.otherElements.buttons["Submit"].tap()
        XCTAssertTrue(app.alerts["Information"].exists)
        app.alerts["Information"].scrollViews.otherElements.buttons["OK"].tap()
        app.terminate()
    }
    
    func testValidFormSubmission(){
        
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
        
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.datePickers/*@START_MENU_TOKEN@*/.pickerWheels["2020"]/*[[".pickers.pickerWheels[\"2020\"]",".pickerWheels[\"2020\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        elementsQuery.buttons["Submit"].tap()
        sleep(10)
        app.alerts["Information"].scrollViews.otherElements.buttons["OK"].tap()
        XCTAssertTrue(app.navigationBars["Confirmation"].exists)
        app.terminate()
    }
    
    func testAdminButton(){
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["USW Interest Form"].buttons["Admin"].tap()
        XCTAssertTrue(app.navigationBars["Admin Login"].exists)
        app.terminate()
    }
}
