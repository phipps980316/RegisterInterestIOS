//
//  NetworkTests.swift
//  RegisterInterestAppTests
//
//  Created by Jon Phipps on 14/03/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import Foundation
import XCTest
@testable import RegisterInterestApp

class NetworkTests: XCTestCase {
    let networkManager = NetworkManager()
    var subjects:[String] = []
    
    func testDidReceiveSubjectAreas(){
        networkManager.getSubjectsFromURL(){(result) in
            self.subjects = result
            DispatchQueue.main.async {
                XCTAssertTrue(self.subjects.count > 0)
            }
        }
    }
    
    func testDidSendRecord(){
        let participant = Participant(name: "Jon Phipps", email: "jphipps@gmail.com", dob: "01/01/1990", subjectArea: "Computing", marketingUpdates: true, gpsLat: 0, gpsLon: 0)
        networkManager.postSubjectToURL(participant: participant!){(result) in
            XCTAssertTrue(result == "Data Saved Successfully")
        }
    }
}
