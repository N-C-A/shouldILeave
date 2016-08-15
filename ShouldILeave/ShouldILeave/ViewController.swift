//
//  ViewController.swift
//  ShouldILeave
//
//  Created by Nicola on 11/07/2016.
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    var datasource = SILArrivalsContext ()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "TrainCell")
        tableView?.dataSource = datasource
        tableView?.delegate = self
        loadData()
    }
    
    func loadData() {
        
        let url = NSURL(string: "https://api.tfl.gov.uk/Line/central/Arrivals/940GZZLUBND?direction=inbound&app_id=3aee5ec5&app_key=6f62b916e190dfc33d248160d3cbbd0e")
        
        SILRequest.sendRequest(url: url!) { (response) in
            let trainsResults = fetchUpcomingTrains(response)
            
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                switch trainsResults {
                case let .Success(trains):
                    print("\(trains)")
                    self.datasource.trains = trains
                case .Failure():
                    self.datasource.trains.removeAll()
                    print("")
                }
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

