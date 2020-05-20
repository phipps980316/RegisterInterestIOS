//
//  Message.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 03/03/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import Foundation

//Struct to represent the response message received from the server
struct Message: Decodable {
    //Variable to hold the message received
    var message: String
}
