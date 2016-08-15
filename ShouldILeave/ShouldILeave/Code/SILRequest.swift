//
//  SILTrainRequest.swift
//  ShouldILeave
//
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit



class SILRequest: NSObject {
    
    
    class func sendRequest(url url: NSURL, completion: (NSData?) -> Void)  {
        
        let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        var dataTask: NSURLSessionDataTask? = nil
        
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        dataTask = defaultSession.dataTaskWithURL(url) {
            (data, response, error) in
            completion(data)
        }
        dataTask?.resume()
    }
    

    

}
