//
//  SILTrainRequest.swift
//  ShouldILeave
//
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit



class SILTrainRequest: NSObject {
    
    
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    var dataTask: NSURLSessionDataTask? = nil
    
    func sendRequest(completion: (NSData?)-> Void)  {
        let url = NSURL(string: "https://api.tfl.gov.uk/Line/central/Arrivals/940GZZLUBND?direction=inbound&app_id=3aee5ec5&app_key=6f62b916e190dfc33d248160d3cbbd0e")
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        
        dataTask = defaultSession.dataTaskWithURL(url!) {
            (data, response, error) in
            completion(data)
        }
        dataTask?.resume()
    }
    
    

}
