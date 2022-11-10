//
//  DurationPickerViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 03/11/22.
//

import UIKit
import SnapKit
import Combine

struct Duration {
    let unix: Int
    let human: String
}

class DurationPickerViewController: UIViewController {
    
    private var addJobVC = AddJobViewController()
    
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
        bindSubscriptions()
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
        addJobVC.duration = durationValue
        
        print("VC duratioin value: ", addJobVC.duration)
        dismiss(animated: true)
    }
    
    private func bindSubscriptions() {
        let publisher = NotificationCenter.Publisher(center: .default, name: Notification.Name("duration"), object: nil)
            .map { (notification) -> String? in
                return (notification.object as? Duration)?.human ?? ""
            }
        
        let subscriber = Subscribers.Assign(object: addJobVC.jobDurationInput.titleLabel?.text, keyPath: \.)
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
