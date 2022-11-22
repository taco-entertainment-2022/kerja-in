//
//  FilterViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 22/11/22.
//

import UIKit
import Combine
import FirebaseFirestore

class FilterViewController: UIViewController {
    
    let viewConstraints = ViewConstraints()
    var respondentQuery = false
    var serviceQuery = false
    var driverQuery = false
    var otherQuery = false
    var onlineQuery = false
    var offlineQuery = false
    
    private lazy var modalTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Filter Pekerjaan"
        label.font = UIFont.Outfit(.semiBold, size: 20)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var categoryDivider: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = UIColor(named: "DividerGray")
        
        return divider
    }()
    
    private lazy var filterByCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Kategori pekerjaan"
        label.font = UIFont.Outfit(.semiBold, size: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var respondentSwitch: CheckboxWithTitle = {
        let checkbox = CheckboxWithTitle(labelText: "Respondent")
        
        return checkbox
    }()
    
    private lazy var serviceSwitch: CheckboxWithTitle = {
        let checkbox = CheckboxWithTitle(labelText: "Service")
        
        return checkbox
    }()
    
    private lazy var driverSwitch: CheckboxWithTitle = {
        let checkbox = CheckboxWithTitle(labelText: "Driver")
        
        return checkbox
    }()
    
    private lazy var otherSwitch: CheckboxWithTitle = {
        let checkbox = CheckboxWithTitle(labelText: "Lain - lain")
        
        return checkbox
    }()

    private lazy var locationDivider: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = UIColor(named: "DividerGray")
        
        return divider
    }()
    
    private lazy var locationyCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Lokasi"
        label.font = UIFont.Outfit(.semiBold, size: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var onlineSwitch: CheckboxWithTitle = {
        let checkbox = CheckboxWithTitle(labelText: "Online")
        
        return checkbox
    }()
    
    private lazy var offlineSwitch: CheckboxWithTitle = {
        let checkbox = CheckboxWithTitle(labelText: "Offline")
        
        return checkbox
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 26
        button.setTitle("Apply", for: .normal)
        button.backgroundColor = UIColor(named: "DarkBlue")
        button.titleLabel?.font = UIFont.Outfit(.medium, size: 20)
        button.addTarget(self, action: #selector(didTapApply), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        integrateCheckbox()
    }
    
    private func setLayout() {
        view.backgroundColor = .white
        
        view.addSubview(modalTitle)
        modalTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
        }
        
        view.addSubview(categoryDivider)
        categoryDivider.snp.makeConstraints { make in
            make.top.equalTo(modalTitle.snp.bottom).offset(25)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.width.equalTo(350)
            make.height.equalTo(1)
        }
        
        view.addSubview(filterByCategoryLabel)
        filterByCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryDivider.snp.bottom).offset(25)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
        }
        
        view.addSubview(respondentSwitch)
        respondentSwitch.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(filterByCategoryLabel.snp.bottom).offset(12)
            make.left.equalToSuperview()
        }
        
        view.addSubview(serviceSwitch)
        serviceSwitch.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(respondentSwitch.snp.bottom).offset(12)
            make.left.equalToSuperview()
        }
        
        view.addSubview(driverSwitch)
        driverSwitch.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(serviceSwitch.snp.bottom).offset(12)
            make.left.equalToSuperview()
        }
        
        view.addSubview(otherSwitch)
        otherSwitch.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(driverSwitch.snp.bottom).offset(12)
            make.left.equalToSuperview()
        }
        
        view.addSubview(locationDivider)
        locationDivider.snp.makeConstraints { make in
            make.top.equalTo(otherSwitch.snp.bottom).offset(25)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.width.equalTo(350)
            make.height.equalTo(1)
        }
        
        view.addSubview(locationyCategoryLabel)
        locationyCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(locationDivider.snp.bottom).offset(25)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
        }
        
        view.addSubview(onlineSwitch)
        onlineSwitch.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(locationyCategoryLabel.snp.bottom).offset(20)
            make.left.equalToSuperview()
        }
        
        view.addSubview(offlineSwitch)
        offlineSwitch.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(onlineSwitch.snp.bottom).offset(12)
            make.left.equalToSuperview()
        }
        
        view.addSubview(applyButton)
        applyButton.snp.makeConstraints { make in
            make.width.equalTo(viewConstraints.textFieldWidth)
            make.height.equalTo(viewConstraints.textFieldHeight)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func integrateCheckbox() {
        let respondentGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRespondent))
        respondentSwitch.addGestureRecognizer(respondentGesture)
        
        let serviceGesture = UITapGestureRecognizer(target: self, action: #selector(didTapService))
        serviceSwitch.addGestureRecognizer(serviceGesture)
        
        let driverGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDriver))
        driverSwitch.addGestureRecognizer(driverGesture)
        
        let otherGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOther))
        otherSwitch.addGestureRecognizer(otherGesture)
        
        let onlineGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnline))
        onlineSwitch.addGestureRecognizer(onlineGesture)
        
        let offlineGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOffline))
        offlineSwitch.addGestureRecognizer(offlineGesture)
    }
    
    @objc private func didTapRespondent() {
        respondentSwitch.toggle()
        
        if respondentSwitch.isChecked == true {
            respondentQuery = true
        } else {
            respondentQuery = false
        }
    }
    
    @objc private func didTapService() {
        serviceSwitch.toggle()
        
        if serviceSwitch.isChecked == true {
            serviceQuery = true
        } else {
            serviceQuery = false
        }
    }
    
    @objc private func didTapDriver() {
        driverSwitch.toggle()
        
        if driverSwitch.isChecked == true {
            driverQuery = true
        } else {
            driverQuery = false
        }
    }
    
    @objc private func didTapOther() {
        otherSwitch.toggle()
        
        if otherSwitch.isChecked == true {
            otherQuery = true
        } else {
            otherQuery = false
        }
    }
    
    @objc private func didTapOnline() {
        onlineSwitch.toggle()
        
        if onlineSwitch.isChecked == true {
            onlineQuery = true
        } else {
            onlineQuery = false
        }
    }
    
    @objc private func didTapOffline() {
        offlineSwitch.toggle()
        
        if offlineSwitch.isChecked == true {
            offlineQuery = true
        } else {
            offlineQuery = false
        }
    }
    
    @objc private func didTapApply() {
        
        JobViewViewModel.shared.respondent = respondentQuery
        JobViewViewModel.shared.service = serviceQuery
        JobViewViewModel.shared.driver = driverQuery
        JobViewViewModel.shared.other = otherQuery
        JobViewViewModel.shared.online = onlineQuery
        JobViewViewModel.shared.offline = offlineQuery

        dismiss(animated: true)
    }
}
