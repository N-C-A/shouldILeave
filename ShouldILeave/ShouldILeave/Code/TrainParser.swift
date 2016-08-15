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
    formatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
    return formatter
}()

func fetchUpcomingTrains(data: NSData?) -> RequestResult {
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

func trainsFromJSON(json: [String: AnyObject]) -> Train? {
    
    guard let destinationStation  = json["stationName"] as? String,
    direction = json["direction"] as? String,
    expectedArrival = json["expectedArrival"] as? NSDate,
    lineID = json["lineId"] as? String,
    timestamp = json["timestamp"] as? NSDate,
    trainID  = json["id"] as? String
    else {
        return nil
    }
    
    return Train(destinationStation: destinationStation, direction: direction, expectedArrival: expectedArrival, lineID: lineID, timestamp: timestamp,trainID: trainID)
}
}