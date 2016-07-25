//
//  SILRequest.swift
//  ShouldILeave
//
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit

class SILRequest: NSObject {
    
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    var dataTask: NSURLSessionDataTask? = nil
    
    func sendRequest() {
        let url = NSURL(string: "https://api.tfl.gov.uk/Line/central/Arrivals/940GZZLUBND?direction=inbound&app_id=3aee5ec5&app_key=6f62b916e190dfc33d248160d3cbbd0e")
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        
        dataTask = defaultSession.dataTaskWithURL(url!) {
            (data, response, error) in
            
            if let jsonData = data {
                do {
                    let jsonObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
                    print(jsonObject)
                } catch _ {
                    print("Error creating JSON object")
                }
            } else if let requestError = error {
                print("Error with request: \(requestError)")
            } else {
                print("Unexpected request error")
            }
        }
        dataTask?.resume()
    }

}
