//
//  ValidationTests.swift
//  RegisterInterestAppTests
//
//  Created by Jon Phipps on 14/03/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import Foundation
import XCTest
@testable import RegisterInterestApp

class ValidationTests: XCTestCase {
    let validationManager = ValidationManager()
    let dateFormatter = DateFormatter()
    
    override func setUp() {
        dateFormatter.dateFormat = "dd/MM/yyyy"
    }
    
    //Date Validation
    func testCurrentDate(){
        //current date
        let currentDate = dateFormatter.date(from: "22/03/2020")
        XCTAssertFalse(validationManager.validAge(birthDate: currentDate!))
    }
    
    func testYesterdayDate(){
        //yesterday date
        let yesterdayDate = dateFormatter.date(from: "21/03/2020")
        XCTAssertFalse(validationManager.validAge(birthDate: yesterdayDate!))
    }

    func testTomorrowDate(){
        //tomorrow date
        let tomorrowDate = dateFormatter.date(from: "23/03/2020")
        XCTAssertFalse(validationManager.validAge(birthDate: tomorrowDate!))
    }
    
    func testLessThanSixteenYearsDate(){
        //less than 16 years ago
        let date = dateFormatter.date(from: "22/03/2010")
        XCTAssertFalse(validationManager.validAge(birthDate: date!))
    }
    
    func testMoreThanSixteenYearsDate(){
        //more than 16 years ago
        let date = dateFormatter.date(from: "22/03/2000")
        XCTAssertTrue(validationManager.validAge(birthDate: date!))
    }
    
    func testExactlySixteenYearsDate(){
        //exactly 16 years ago
        let date = dateFormatter.date(from: "22/03/2004")
        XCTAssertTrue(validationManager.validAge(birthDate: date!))
    }
    
    func testOneDayBeforeSixteenYearsDate(){
        //16years ago minus 1 day
        let date = dateFormatter.date(from: "23/03/2004")
        XCTAssertFalse(validationManager.validAge(birthDate: date!))
    }
    
    func testOneDayAfterSixteenYearsDate(){
        //16years ago plus 1 day
        let date = dateFormatter.date(from: "22/03/2004")
        XCTAssertTrue(validationManager.validAge(birthDate: date!))
    }
    
    //Email Validation
    func testValidEmails() {
        XCTAssertTrue(validationManager.validEmail(email: "abc123@gmail.com"))
        XCTAssertTrue(validationManager.validEmail(email: "abc123.def456@gmail.com"))
        XCTAssertTrue(validationManager.validEmail(email: "abc123.def456@gmail.co.uk"))
        XCTAssertTrue(validationManager.validEmail(email: "abc123_def456@gmail.co.uk"))
        XCTAssertTrue(validationManager.validEmail(email: "abc123-def456@gmail.co.uk"))
    }
    
    func testInvalidEmails() {
        XCTAssertFalse(validationManager.validEmail(email: "abc123"))
        XCTAssertFalse(validationManager.validEmail(email: "abc123@gmail"))
        XCTAssertFalse(validationManager.validEmail(email: ".abc123@gmail.com"))
        XCTAssertFalse(validationManager.validEmail(email: ".abc123.@gmail.com"))
        XCTAssertFalse(validationManager.validEmail(email: "abc..123@gmail.com"))
        XCTAssertFalse(validationManager.validEmail(email: "abc--123@gmail.com"))
        XCTAssertFalse(validationManager.validEmail(email: "abc123@gm"))
        XCTAssertFalse(validationManager.validEmail(email: "abc123@g.c"))
        XCTAssertFalse(validationManager.validEmail(email: "@gmail.com"))
    }
}
