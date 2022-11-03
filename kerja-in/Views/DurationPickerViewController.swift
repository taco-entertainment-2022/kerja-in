//
//  DurationPickerViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 03/11/22.
//

import UIKit

class DurationPickerViewController: UIViewController {
    
    let numPicker = Array(1...60)
    let durationPicker = ["Menit", "Jam", "Hari", "Bulan", "Tahun"]
    
    private lazy var durationPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        durationPickerView.delegate = self
        durationPickerView.dataSource = self
    }
}

extension DurationPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return numPicker.count
        }
        
        return durationPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(numPicker[row])"
        }
        
        return "\(durationPicker[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let numSelected = numPicker[pickerView.selectedRow(inComponent: 0)]
        let durationSelected = durationPicker[pickerView.selectedRow(inComponent: 1)]
        
        print(numSelected, durationSelected)
    }
}
