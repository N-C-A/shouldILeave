//
//  SILArrivalsContext.swift
//  ShouldILeave
//
//  Created by Nicola on 25/07/2016.
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit

class SILArrivalsContext:NSObject, UITableViewDataSource {
    
    var trains: [Train] = []
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "TrainCell"
        let cell =
            tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let train = trains[(indexPath as NSIndexPath).row]
        
        
        let currentCalendar = Calendar.current

        let dateComponents = (currentCalendar as NSCalendar).components(.minute, from: train.timestamp, to: train.expectedArrival, options: NSCalendar.Options.wrapComponents)
        
        
        cell.textLabel?.text = "\(dateComponents.minute) mins"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trains.count
    }
}
