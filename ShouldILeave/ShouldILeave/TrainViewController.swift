//
//  ViewController.swift
//  ShouldILeave
//
//  Created by Nicola on 11/07/2016.
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit

class TrainViewController: UIViewController, UITableViewDelegate {

    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.isLenient = true
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    var datasource = TrainViewControllerDataSource ()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var lastRefreshed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TrainCell")
        tableView?.dataSource = datasource
        tableView?.delegate = self
        let line = "central"
        let station = "940GZZLUBND"
        let direction = "inbound"
        loadData(withLine: line, withStation: station, withDirection: direction)
    }
    
    
    @IBAction func refreshData(_ sender: AnyObject) {
        
        let line = "central"
        let station = "940GZZLUBND"
        let direction = "inbound"
        loadData(withLine: line, withStation: station, withDirection: direction)
    }
    
    func loadData(withLine line: String, withStation station: String, withDirection direction: String) {
        
        let urlString = String(format: "https://api.tfl.gov.uk/Line/%@/Arrivals/%@?direction=%@&app_id=3aee5ec5&app_key=6f62b916e190dfc33d248160d3cbbd0e", line, station, direction)
        
        let url = URL(string: urlString)
        
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
                
                let now = Date.init()
                let dateString = self.dateFormatter.string(from: now)
                self.lastRefreshed.text = "Last refreshed \(dateString)"
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

