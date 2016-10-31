//
//  ViewController.swift
//  ShouldILeave
//
//  Created by Nicola on 11/07/2016.
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit

class TrainViewController: UIViewController, UITableViewDelegate, StationPickerDelegate, LinePickerDelegate {

    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.isLenient = true
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    var trainDataSource = TrainViewControllerDataSource()
    var stationDataSource = StationPickerViewDataSource()
    let lineDataSource = LinePickerViewDataSource()
    var selectedStation: String = "940GZZLUBND"
    var selectedLine:String = "central"
    var selectedDirection:String = "inbound"
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var lastRefreshed: UILabel!
    @IBOutlet weak var stationButton: UIButton!
    @IBOutlet weak var lineButton: UIButton!
    @IBOutlet weak var directionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TrainCell")
        tableView?.dataSource = trainDataSource
        tableView?.delegate = self
        
        populateStationDataSource()
        populateLineDataSource()
        stationDataSource.delegate = self
        lineDataSource.delegate = self
        
        pickerView?.isHidden = true
        
        loadData()
    }
    
    
    @IBAction func refreshData(_ sender: AnyObject) {
        
        loadData()
    }
    
    @IBAction func toggleStationPicker(_ sender: AnyObject) {
        
        if let pickerView = pickerView {
            
            pickerView.dataSource = stationDataSource
            pickerView.delegate = stationDataSource
            
            pickerView.isHidden = !pickerView.isHidden
        
        }
    }
    
    @IBAction func toggleLinePicker(_ sender: UIButton) {
        
        if let pickerView = pickerView {
            
            pickerView.dataSource = lineDataSource
            pickerView.delegate = lineDataSource
            
            pickerView.isHidden = !pickerView.isHidden
            
        }
    }
    
    
    func loadData() {
        
        let urlString = String(format: "https://api.tfl.gov.uk/Line/%@/Arrivals/%@?direction=%@&app_id=3aee5ec5&app_key=6f62b916e190dfc33d248160d3cbbd0e", selectedLine, selectedStation, selectedDirection)
        
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
        // TODO: turn this into a request
        let station1 = Station(ID: "940GZZLUBND", name: "Bond Street")
        let station2 = Station(ID: "HUBEAL", name: "Ealing Broadway")
        
        stationDataSource.stations = [station1, station2]
    }
    
    func populateLineDataSource() {
        // TODO: turn this into a request
        let line = Line(ID: "central", name: "Central")
        
        lineDataSource.lines = [line]
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: StationPickerDelegate
    
    func stationWasSelected(station: Station) {
        selectedStation = station.ID
        stationButton.setTitle(station.name, for: .normal)
    }
    
    func lineWasSelected(line: Line) {
        selectedLine = line.ID
        lineButton.setTitle(line.name, for: .normal)
    }

}

