//
//  Participant.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 27/01/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import UIKit

//Class to represent a person filling out the interest form
class Participant:Codable{
    
    //Variables to hold the persons details and choices
    var Name:String
    var Email:String
    var DOB:String
    var SubjectArea:String
    var MarketingUpdates:Bool
    var GpsLat:Double
    var GpsLon:Double
    
    //Constructor to create a participant object based on the supplied parameters
    init?(name:String, email:String, dob:String, subjectArea:String, marketingUpdates:Bool, gpsLat:Double, gpsLon:Double){
        self.Name = name
        self.Email = email
        self.DOB = dob
        self.SubjectArea = subjectArea
        self.MarketingUpdates = marketingUpdates
        self.GpsLat = gpsLat
        self.GpsLon = gpsLon
    }
    
    //Getter to return name
    public func getNameString() -> String{
        return self.Name
    }
    
    //Getter to return email
    public func getEmailString() -> String{
        return self.Email
    }
    
    //Getter to return date of birth
    public func getDOBString() -> String{
        return self.DOB
    }
    
    //Getter to return subject area
    public func getSubjectAreaString() -> String{
        return self.SubjectArea
    }
    
    //Getter to return marketing updates choice
    public func getMarketingUpdatesString() -> String{
        var marketingChoice = ""
        if (self.MarketingUpdates) {marketingChoice = "True"}
        else {marketingChoice = "False"}
        return marketingChoice
    }
    
    //Getter to return latitude gps coordinate
    public func getGPSLatString() -> String{
        return String(self.GpsLat)
    }
    
    //Getter to return longitude gps coordinate
    public func getGPSLonString() -> String{
        return String(self.GpsLon)
    }
}
