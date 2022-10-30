//
//  AddJobViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 18/10/22.
//

import UIKit

class AddJobViewController: UIViewController {
    
    private let jobTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Judul Pekerjaan"
        return label
    }()
    
    private let jobTitleInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let jobDescriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Deskripsi Pekerjaan"
        
        return label
    }()
    
    private let jobDescriptionInput: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(named: "LightGray")
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return textView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Pilih Kategori"
        
        return label
    }()
    
    private let categoryInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.placeholder = "Pilih Kategori"
        
        return textField
    }()
    
    private let jobDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Durasi Pekerjaan"
        
        return label
    }()
    
    private let jobDurationInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Lokasi"
        
        return label
    }()
    
    private let locationInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let feeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Bayaran"
        
        return label
    }()
    
    private let feeInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let contactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Nomor Whatsapp"
        
        return label
    }()
    
    private let contactInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let jobDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Waktu Pengerjaan"
        
        return label
    }()
    
    private let jobDateInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 26
        button.setTitle("Post Job", for: .normal)
        button.backgroundColor = UIColor(named: "DarkBlue")
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "DarkBlue")
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = UIColor(named: "White")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
    
        setUpViews()
    }
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .red
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private func setUpViews() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        let views = [jobTitleLabel, jobTitleInput, jobDescriptionLabel, jobDescriptionInput, categoryLabel, categoryInput, jobDurationLabel, jobDurationInput, locationLabel, locationInput, feeLabel, feeInput, contactLabel, contactInput, jobDateLabel, jobDateInput, createButton]
        
        for i in 0..<views.count {
            scrollView.addSubview(views[i])
        }
        
        jobTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        
        jobTitleInput.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobTitleLabel.snp.bottom).offset(7)
        }
        
        jobDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobTitleInput.snp.bottom).offset(20)
        }
        
        jobDescriptionInput.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobDescriptionLabel.snp.bottom).offset(7)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobDescriptionInput.snp.bottom).offset(20)
        }
        
        categoryInput.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).offset(7)
        }
        
        jobDurationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryInput.snp.bottom).offset(20)
        }
        
        jobDurationInput.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobDurationLabel.snp.bottom).offset(7)
        }
        
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobDurationInput.snp.bottom).offset(20)
        }
        
        locationInput.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom).offset(7)
        }
        
        feeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(locationInput.snp.bottom).offset(20)
        }
        
        feeInput.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(feeLabel.snp.bottom).offset(7)
        }
        
        contactLabel.snp.makeConstraints { (make) in
            make.top.equalTo(feeInput.snp.bottom).offset(20)
        }
        
        contactInput.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(contactLabel.snp.bottom).offset(7)
        }
        
        jobDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contactInput.snp.bottom).offset(20)
        }
        
        jobDateInput.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobDateLabel.snp.bottom).offset(7)
        }
        
        createButton.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobDateInput.snp.bottom).offset(45)
        }
    }
}
