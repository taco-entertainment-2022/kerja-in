//
//  JobDatePickerViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 09/11/22.
//

import UIKit
import SnapKit

class JobDatePickerViewController: UIViewController {
    
    private lazy var datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = .white
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = .current
        
        return datePicker
    }()
    
    private lazy var saveDatePickerValueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 26
        button.setTitle("Simpan", for: .normal)
        button.backgroundColor = UIColor(named: "DarkBlue")
        button.addTarget(self, action: #selector(didChangeJobDateValue), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        styleLayouts()
    }
    
    @objc private func didChangeJobDateValue() {
        print("job date pressed \(datePickerView.date)")
        let addJob = AddJobViewController()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        let dateToString = dateFormatter.string(from: datePickerView.date)
        addJob.jobDate = dateToString
        addJob.jobDateInput.titleLabel?.text = dateToString
        
        dismiss(animated: true)
    }
    
    private func styleLayouts() {
        view.addSubview(datePickerView)
        view.addSubview(saveDatePickerValueButton)
        
        datePickerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
        }
        
        saveDatePickerValueButton.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(datePickerView.snp.bottom).offset(40)
        }
    }
}
