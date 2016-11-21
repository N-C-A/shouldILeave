//
//  TrainParser.swift
//  ShouldILeave
//
//  Created by Nicola on 08/08/2016.
//  Copyright © 2016 Medusa. All rights reserved.
//

import Foundation

enum RequestResult{
    case success([Train])
    case failure
}
class TrainParser {
     fileprivate static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.isLenient = true
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter
    }()
    fileprivate static let dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.isLenient = true
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSSS.SSSS'Z'"
        return formatter
    }()
    
    
    class func fetchUpcomingTrains(_ data: Data?) -> RequestResult {
        guard let jsonData = data else {
            return .failure
        }
        
        
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            guard let
                trainsArray = jsonObject as? [[String:AnyObject]] else {
                    
                    return .failure
            }
            
            var finalTrains = [Train]()
            
            for trainJSON in trainsArray {
                if let train = trainsFromJSON(trainJSON) {
                    finalTrains.append(train)
                }
            }
            
            if finalTrains.isEmpty && !trainsArray.isEmpty {
                
                return .failure
            }
            let sorted = finalTrains.sorted(by: { (train1, train2) -> Bool in
                return train1.expectedArrival < train2.expectedArrival
            })
            return .success(sorted)
        }
        catch _  {
            return .failure
        }
        
    }
    
    class func trainsFromJSON(_ json: [String: AnyObject]) -> Train? {
        
        guard let destinationStation  = json["stationName"] as? String,
            let direction = json["direction"] as? String,
            let expectedArrivalString = json["expectedArrival"] as? String,
            let lineID = json["lineId"] as? String,
            let timestampString = json["timestamp"] as? String,
            let trainID  = json["id"] as? String,
            let expectedArrival = dateFormatter2.date(from: expectedArrivalString),
            let timestamp = dateFormatter.date(from: timestampString)
            else {
                return nil
        }
        
        return Train(destinationStation: destinationStation, direction: direction, expectedArrival: expectedArrival, lineID: lineID, timestamp: timestamp,trainID: trainID)
    }
}
