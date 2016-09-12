//
//  TrainParser.swift
//  ShouldILeave
//
//  Created by Nicola on 08/08/2016.
//  Copyright © 2016 Medusa. All rights reserved.
//

import Foundation
import CoreData

enum RequestResult{
    case Success([Train])
    case Failure
}
class TrainParser {
     private static let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.lenient = true
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter
    }()
    private static let dateFormatter2: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.lenient = true
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSS.SSSS'Z'"
        return formatter
    }()
    
    
    class func fetchUpcomingTrains(data: NSData?) -> RequestResult {
        guard let jsonData = data else {
            return .Failure
        }
        
        do {
            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
            
            guard let
                trainsArray = jsonObject as? [[String:AnyObject]] else {
                    
                    return .Failure
            }
            
            var finalTrains = [Train]()
            
            for trainJSON in trainsArray {
                if let train = trainsFromJSON(trainJSON) {
                    finalTrains.append(train)
                }
            }
            
            if finalTrains.isEmpty && !trainsArray.isEmpty {
                
                return .Failure
            }
            return .Success(finalTrains)
        }
        catch _  {
            return .Failure
        }
        
    }
    
    class func trainsFromJSON(json: [String: AnyObject]) -> Train? {
        
        guard let destinationStation  = json["stationName"] as? String,
            direction = json["direction"] as? String,
            expectedArrivalString = json["expectedArrival"] as? String,
            lineID = json["lineId"] as? String,
            timestampString = json["timestamp"] as? String,
            trainID  = json["id"] as? String,
            expectedArrival = dateFormatter2.dateFromString(expectedArrivalString),
            timestamp = dateFormatter.dateFromString(timestampString)
            else {
                return nil
        }
        
        return Train(destinationStation: destinationStation, direction: direction, expectedArrival: expectedArrival, lineID: lineID, timestamp: timestamp,trainID: trainID)
    }
}