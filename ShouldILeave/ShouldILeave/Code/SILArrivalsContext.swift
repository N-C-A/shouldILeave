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
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "TrainCell"
        let cell =
            tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trains.count
    }
}
