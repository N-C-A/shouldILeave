//
//  SILTrainRequest.swift
//  ShouldILeave
//
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit

enum RequestResult{
    case Success([Train])
    case Failure
}

class SILTrainRequest: NSObject {
    
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    var dataTask: NSURLSessionDataTask? = nil
    
    func sendRequest() {
        let url = NSURL(string: "https://api.tfl.gov.uk/Line/central/Arrivals/940GZZLUBND?direction=inbound&app_id=3aee5ec5&app_key=6f62b916e190dfc33d248160d3cbbd0e")
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        
        dataTask = defaultSession.dataTaskWithURL(url!) {
            (data, response, error) in
            
            fetchUpcomingTrains(data)
        }
        dataTask?.resume()
    }
    
    func fetchUpcomingTrains(data: NSData) -> RequestResult {
        guard let jsonData = data else {
            return .Failure()
        }
        
        do {
            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            
            guard let
                jsonDictionary = jsonObject as? [NSObject:AnyObject],
                trainsArray = jsonDictionary as? [String:AnyObject] else {
                    
                    return .Failure()
            }
            
            var finalTrains = [Train]()
            
            for trainJSON in trainsArray {
                //
            }
            
            if finalTrains.isEmpty && !trainsArray.isEmpty {
                
                return .Failure()
            }
            return .Success(finalTrains)
        }
        catch let error {
            return .Failure()
        }

    }

}
