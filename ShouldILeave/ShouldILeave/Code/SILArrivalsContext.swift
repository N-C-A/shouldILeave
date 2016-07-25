//
//  SILArrivalsContext.swift
//  ShouldILeave
//
//  Created by Nicola on 25/07/2016.
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit

@objc class SILArrivalsContext:NSObject, UITableViewDataSource {
    
    var strings:Array<String> = []
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.count
    }
}
