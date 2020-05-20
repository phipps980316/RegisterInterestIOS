//
//  NetworkManager.swift
//  RegisterInterestApp
//
//  Created by Jon Phipps on 03/03/2020.
//  Copyright © 2020 Jon Phipps. All rights reserved.
//

import Foundation
import UIKit

//Class to manage all of the network requests
class NetworkManager{
    
    //Function to fetch all of the subject area strings from the url provided and return them through a completion handler
    public func getSubjectsFromURL(completion: @escaping ([String]) -> Void) {
        let urlString = "https://prod-42.westeurope.logic.azure.com:443/workflows/bde222cb4461471d90691324f4b6861f/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=rPL5qFWfWLPKNk3KhRuP0fsw4ooSYczKXuNfCAtDjPA"
        guard let url = URL(string: urlString) else {return}
        var fetchedSubjects: [String] = []
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{(data, response, error) -> Void in
            if let json = try? JSONSerialization.jsonObject(with: data!, options:.mutableContainers) as? NSArray {
                for entry in json{
                    let s = Subject(json: entry as! [String:Any])
                    fetchedSubjects.append(s!.name)
                }
                completion(fetchedSubjects)
            }
            else{
                completion([])
            }
        })
        task.resume()
    }
    
    //Function to post completed participant details to the url provided and return a response message through a completion handler
    public func postSubjectToURL(participant: Participant, completion: @escaping (String) -> Void) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys,.prettyPrinted,.withoutEscapingSlashes]
        
        let JSONData = (try? encoder.encode(participant)) ?? Data()
    
        let urlString = "https://prod-69.westeurope.logic.azure.com:443/workflows/d2ec580e6805459893e498d43f292462/triggers/manual/paths/invoke?api-version=2016-06-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=zn8yq-Xe3cOCDoRWTiLwDsUDXAwdGSNzxKL5OUHJPxo"
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = JSONData
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{(data, response, error) -> Void in
            if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                completion(error.localizedDescription + " Try Again Later")
                return
            }
            guard let data = data else {
                return
            }
        
            let responseJSON = try? JSONDecoder().decode(Message.self, from: data)
            completion(responseJSON?.message ?? "")
        })
        task.resume()
    }
}
