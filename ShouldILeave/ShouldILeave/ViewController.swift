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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TrainCell")
        tableView?.dataSource = datasource
        tableView?.delegate = self
        loadData()
    }
    
    func loadData() {
        
        let url = URL(string: "https://api.tfl.gov.uk/Line/central/Arrivals/940GZZLUBND?direction=inbound&app_id=3aee5ec5&app_key=6f62b916e190dfc33d248160d3cbbd0e")
        
        SILRequest.sendRequest(url: url!) { (response) in
            let trainsResults = TrainParser.fetchUpcomingTrains(response)
            
            OperationQueue.main.addOperation() {
                switch trainsResults {
                case let .success(trains):
                    print("\(trains)")
                    self.datasource.trains = trains
                case .failure():
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

