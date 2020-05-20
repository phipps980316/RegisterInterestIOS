//
//  DataManager.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 29/02/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//Class to manage all core data requests
class DataManager{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Function to insert a new record into core data to save the record
    public func insertRecord(participant: Participant){
        let context = appDelegate.persistentContainer.viewContext
        
        context.perform {
            let entity = NSEntityDescription.entity(forEntityName: "Participants", in: context)
            let newParticipant = NSManagedObject(entity: entity!, insertInto: context)
            
            newParticipant.setValue(participant.Name, forKey: "name")
            newParticipant.setValue(participant.Email, forKey: "email")
            newParticipant.setValue(participant.DOB, forKey: "dob")
            newParticipant.setValue(participant.SubjectArea, forKey: "subjectarea")
            newParticipant.setValue(participant.MarketingUpdates, forKey: "marketingupdates")
            newParticipant.setValue(participant.GpsLat, forKey: "gpslat")
            newParticipant.setValue(participant.GpsLon, forKey: "gpslon")
            
            do{
                try context.save()
            }catch{
                print("Failed to save")
            }
        }
    }
    
    //Function to fetch all of the records stored from core data
    public func getRecords() -> [Participant]{
        var participants = [Participant]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Participants")
        request.returnsObjectsAsFaults=false
        let context = appDelegate.persistentContainer.viewContext
        
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                let name = data.value(forKey: "name") as! String
                let email = data.value(forKey: "email") as! String
                let dob = data.value(forKey: "dob") as! String
                let subjectArea = data.value(forKey: "subjectarea") as! String
                let marketingUpdates = data.value(forKey: "marketingupdates") as! Bool
                let gpsLat = data.value(forKey: "gpslat") as! Double
                let gpsLon = data.value(forKey: "gpslon") as! Double
                
                let participant = Participant.init(name: name, email: email, dob: dob, subjectArea: subjectArea, marketingUpdates: marketingUpdates, gpsLat: gpsLat, gpsLon: gpsLon)
                participants.append(participant!)
            }
        }catch{
            print("Loading Failed")
        }
        return participants
    }
    
    //Function to clear all of the saved data from core data
    public func clearRecords(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Participants")
        request.returnsObjectsAsFaults=false
        let context = appDelegate.persistentContainer.viewContext
        
        if let result = try? context.fetch(request){
            for object in result {
                context.delete(object as! NSManagedObject)
            }
        }
        
        do{
            try context.save()
        }catch{
            print("Failed to save")
        }
    }
}
