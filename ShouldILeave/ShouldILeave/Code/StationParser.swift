//
//  StationParser.swift
//  ShouldILeave
//
//  Created by Nicola Asamoah on 21/11/2016.
//  Copyright © 2016 Medusa. All rights reserved.
//

import Foundation

enum StationResult {
    case success([Station])
    case failure
}

class StationParser {
    
    class func fetchStations(_ data: Data?) -> StationResult {
        guard let data = data else {
            return .failure
        }
        
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonData = jsonObject as? [String:AnyObject], let stationArray = jsonData["matches"] as? [[String:AnyObject]] else {
                return .failure
            }
            
            var finalStations = [Station]()
            
            for stationJSON in stationArray {
                if let station = stationFromJSON(stationJSON) {
                    finalStations.append(station)
                }
            }
            
            if finalStations.isEmpty && !stationArray.isEmpty {
                return .failure
            }
            
            return .success(finalStations)
        } catch _ {
            return .failure
        }
    }
    
    class func stationFromJSON(_ json: [String: AnyObject]) -> Station? {
        guard let modes = json["modes"] as? [String],
            let id = json["id"] as? String,
            let name = json["name"] as? String else {
                return nil
        }
        let tube = modes.contains("tube")
        
        if tube {
             return Station(ID: id, name: name)
        } else {
            return nil
        }
    }
    
}
