//
//  DurationPickerViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 03/11/22.
//

import UIKit
import SnapKit

class DurationPickerViewController: UIViewController {
    
    let numPicker = Array(1...60)
    let durationPicker = ["Menit", "Jam", "Hari", "Bulan", "Tahun"]
    var durationValue = ""
    
    private lazy var durationPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    private lazy var saveDurationValueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 26
        button.setTitle("Simpan", for: .normal)
        button.backgroundColor = UIColor(named: "DarkBlue")
        button.addTarget(self, action: #selector(didChangeDurationValue), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        durationPickerView.delegate = self
        durationPickerView.dataSource = self
        
        view.addSubview(durationPickerView)
        view.addSubview(saveDurationValueButton)
        view.backgroundColor = .systemBackground
        
        styleLayouts()
    }
    
    private func styleLayouts() {
        durationPickerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        saveDurationValueButton.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(durationPickerView.snp.bottom).offset(40)
        }
    }
    
    @objc private func didChangeDurationValue() {
        let vc = AddJobViewController()
        vc.duration = durationValue
        
        print("VC duratioin value: ", vc.duration)
        dismiss(animated: true)
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
        durationValue = "\(numSelected) \(durationSelected)"
    }
}
