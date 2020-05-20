//
//  Validation.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 29/02/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import Foundation

//Class to manage all required form validations
class ValidationManager{
    
    //Function to check if a date is valid and more than or equal 16 years ago
    public func validAge(birthDate:Date) -> Bool {
        let calender = Calendar.current
        let currentDate = Date()
        let ageComponents = calender.dateComponents([.year], from: birthDate, to: currentDate )
        let age = ageComponents.year!
        
        if age >= 16 {
            return true
        } else {
            return false
        }
    }
    
    //Function to check if an email is valid using a regular expression
    public func validEmail(email:String) -> Bool {
        let regex = "[^._-]+([A-Z0-9a-z]+[._-]{0,1})+[^._-]+@[A-Za-z0-9._-]+[.]+[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@",  regex)
        return emailTest.evaluate(with: email)
    }
}
