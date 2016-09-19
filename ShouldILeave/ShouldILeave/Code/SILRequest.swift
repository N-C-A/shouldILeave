//
//  SILTrainRequest.swift
//  ShouldILeave
//
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit



class SILRequest: NSObject {
    
    
    class func sendRequest(url: URL, completion: @escaping (Data?) -> Void)  {
        
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        var dataTask: URLSessionDataTask? = nil
        
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        dataTask = defaultSession.dataTask(with: url, completionHandler: {
            (data, response, error) in
            completion(data)
        }) 
        dataTask?.resume()
    }
    

    

}
