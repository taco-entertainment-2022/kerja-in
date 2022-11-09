//
//  DurationPickerViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 03/11/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class DurationPickerViewController: UIViewController {
    
    let numPicker = Array(1...60)
    let durationPicker = ["Menit", "Jam", "Hari", "Bulan", "Tahun"]
    var durationValue: Observable<String>?
    let bag = DisposeBag()
    
    private lazy var durationPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    private lazy var saveDurationValueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 26
        button.setTitle("Save", for: .normal)
        button.backgroundColor = UIColor(named: "DarkBlue")
        button.titleLabel?.font = UIFont.Outfit(.medium, size: 20)
        button.addTarget(self, action: #selector(didChangeDurationValue), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        durationPickerView.delegate = self
        durationPickerView.dataSource = self
        
        view.backgroundColor = .white
        view.addSubview(durationPickerView)
        view.addSubview(saveDurationValueButton)
        
        styleLayouts()
        populateRx()
    }
    
    @objc private func didChangeDurationValue() {
        let addJobController = AddJobViewController()
//        addJobController.durationInputLabelValue = durationValue
        
        dismiss(animated: true)
    }
    
    private func populateRx() {
        let addJobController = AddJobViewController()
//        durationValue = Observable.of("Durasi").
//        addJobController.jobDurationInputLabel.text
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
        
//        durationValue = "\(numSelected) \(durationSelected)"
    }
    
    func styleLayouts() {
        durationPickerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        saveDurationValueButton.snp.makeConstraints { (make) in
            make.top.equalTo(durationPickerView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(44)
        }
    }
}
