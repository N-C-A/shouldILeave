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
    
    var trainDataSource = TrainViewControllerDataSource()
    var stationDataSource = StationPickerViewDataSource()
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var lastRefreshed: UILabel!
    @IBOutlet weak var stationNutton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TrainCell")
        tableView?.dataSource = trainDataSource
        tableView?.delegate = self
        
        populateStationDataSource()
        
        pickerView?.dataSource = stationDataSource
        pickerView?.delegate = stationDataSource
        
        pickerView?.isHidden = true
        
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
    
    @IBAction func toggleStationPicker(_ sender: AnyObject) {
        pickerView?.dataSource = stationDataSource
        pickerView?.delegate = stationDataSource
    
        let hidden = pickerView?.isHidden
        if let hidden = hidden {
                pickerView?.isHidden = !hidden
        }
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
                    self.trainDataSource.trains = trains
                case .failure():
                    self.trainDataSource.trains.removeAll()
                    print("")
                }
                
                let now = Date.init()
                let dateString = self.dateFormatter.string(from: now)
                self.lastRefreshed.text = "Last refreshed \(dateString)"
                self.tableView.reloadData()
            }
        }
    }
    
    func populateStationDataSource() {
        
        let station1 = Station(ID: "940GZZLUBND", name: "Bond Street")
        let station2 = Station(ID: "HUBEAL", name: "Ealing Broadway")
        
        stationDataSource.stations = [station1, station2]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}

