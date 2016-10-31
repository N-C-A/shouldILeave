//
//  LinePickerViewDataSource.swift
//  ShouldILeave
//
//  Created by Nicola Asamoah on 31/10/2016.
//  Copyright © 2016 Medusa. All rights reserved.
//

import UIKit

public protocol LinePickerDelegate {
    func lineWasSelected(line: Line)
}


class LinePickerViewDataSource:NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    var lines: [Line] = []
    var delegate: LinePickerDelegate?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lines.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let line = lines[row]
        return line.name
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let line = lines[row]
        delegate?.lineWasSelected(line: line)
        
    }
}
