//
//  Subject.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 29/02/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import Foundation

//Struct to represent each subject area
struct Subject: Codable {
    
    //Variable to hold the subject area name
    var name: String
    
    //Constructor to create a subject object from json data
    init?(json:[String:Any]){
        guard let name = json["name"] as? String else {return nil}
        self.name = name
    }
}

