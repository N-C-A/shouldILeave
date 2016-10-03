//
//  StationPIckerViewDataSource.swift
//  ShouldILeave
//
//  Created by Nicola Asamoah on 03/10/2016.
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit

class StationPickerViewDataSource:NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    var stations: [Station] = []
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stations.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let station = stations[row]
        return station.name
    }
    
}
