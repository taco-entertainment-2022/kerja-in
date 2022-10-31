//
//  AddJobViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 18/10/22.
//

import UIKit

class AddJobViewController: UIViewController {
    
    private let textFieldWidth = 350
    private let textFieldHeight = 44
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 900)
        
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var jobTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: 18)
        label.text = "Judul Pekerjaan"
        
        return label
    }()
    
    private lazy var jobTitleInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.delegate = self
        textField.autocapitalizationType = .words
        textField.returnKeyType = .continue
        textField.becomeFirstResponder()
        
        return textField
    }()
    
    private lazy var jobDescriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: 18)
        label.text = "Deskripsi Pekerjaan"
        
        return label
    }()
    
    private lazy var jobDescriptionInput: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(named: "LightGray")
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.delegate = self
        textView.returnKeyType = .continue
        
        return textView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: 18)
        label.text = "Pilih Kategori"
        
        return label
    }()
    
    private lazy var categoryInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.attributedPlaceholder = NSAttributedString(string: "Pilih Kategori", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.semiBold, size: 16)])
        textField.delegate = self
        textField.returnKeyType = .continue
        
        return textField
    }()
    
    private lazy var jobDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: 18)
        label.text = "Durasi Pekerjaan"
        
        return label
    }()
    
    private lazy var jobDurationInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.delegate = self
        textField.returnKeyType = .continue
        
        return textField
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: 18)
        label.text = "Lokasi"
        
        return label
    }()
    
    private lazy var locationInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.attributedPlaceholder = NSAttributedString(string: "Pilih Lokasi", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.semiBold, size: 16)])
        textField.delegate = self
        textField.returnKeyType = .continue
        
        return textField
    }()
    
    private lazy var feeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: 18)
        label.text = "Bayaran"
        
        return label
    }()
    
    private lazy var feeInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    private lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: 18)
        label.text = "Nomor Whatsapp"
        
        return label
    }()
    
    private lazy var contactInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.keyboardType = .phonePad
        
        return textField
    }()
    
    private lazy var jobDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: 18)
        label.text = "Waktu Pengerjaan"
        
        return label
    }()
    
    private lazy var jobDateInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.delegate = self
        textField.returnKeyType = .continue
        
        return textField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 26
        button.setTitle("Post Job", for: .normal)
        button.backgroundColor = UIColor(named: "DarkBlue")
        button.titleLabel?.font = UIFont.Outfit(.medium, size: 20)
        
        return button
    }()
    
    let randomBox: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "DarkBlue")
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.Outfit(.semiBold, size: 20)]
        appearance.backgroundColor = UIColor(named: "DarkBlue")
        
        navigationController?.navigationBar.tintColor = UIColor(named: "White")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
            
        setUpViews()
        createButton.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
    }
    
    private func setUpViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        let views = [jobTitleLabel, jobTitleInput, jobDescriptionLabel, jobDescriptionInput, categoryLabel, categoryInput, jobDurationLabel, jobDurationInput, locationLabel, locationInput, feeLabel, feeInput, contactLabel, contactInput, jobDateLabel, jobDateInput, createButton]

        for i in 0..<views.count {
            stackView.addArrangedSubview(views[i])
        }
        
        scrollView.addSubview(stackView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.left.equalTo(scrollView.snp.left)
            make.right.equalTo(scrollView.snp.right)
            make.height.equalTo(900)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
        }
        
        jobTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
        }
        
        jobTitleInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobTitleLabel.snp.bottom)
        }
        
        jobDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobTitleInput.snp.bottom).offset(20)
        }
        
        jobDescriptionInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobDescriptionLabel.snp.bottom)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobDescriptionInput.snp.bottom).offset(20)
        }
        
        categoryInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom)
        }
        
        jobDurationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryInput.snp.bottom).offset(20)
        }
        
        jobDurationInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobDurationLabel.snp.bottom)
        }
        
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobDurationInput.snp.bottom).offset(20)
        }
        
        locationInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom)
        }
        
        feeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(locationInput.snp.bottom).offset(20)
        }
        
        feeInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(feeLabel.snp.bottom)
        }
        
        contactLabel.snp.makeConstraints { (make) in
            make.top.equalTo(feeInput.snp.bottom).offset(20)
        }
        
        contactInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(contactLabel.snp.bottom)
        }
        
        jobDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contactInput.snp.bottom).offset(20)
        }
        
        jobDateInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobDateLabel.snp.bottom)
        }
        
        createButton.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func didTapCreate() {
        createButton.resignFirstResponder()
        AddJobViewViewModel.shared.jobTitle = jobTitleInput.text!
        AddJobViewViewModel.shared.jobDescription = jobDescriptionInput.text!
        AddJobViewViewModel.shared.category = categoryInput.text!
        AddJobViewViewModel.shared.jobDuration = jobDurationInput.text!
        AddJobViewViewModel.shared.location = locationInput.text!
        AddJobViewViewModel.shared.fee = feeInput.text!
        AddJobViewViewModel.shared.contact = contactInput.text!
        AddJobViewViewModel.shared.jobDate = jobDateInput.text!
        
        print(jobTitleInput.text!, jobDescriptionInput.text!, categoryInput.text!, jobDurationInput.text!, locationInput.text!, feeInput.text!, contactInput.text!, jobDateInput.text!)
    }
    
    @objc func didTapTextField() {
        
    }
}

extension AddJobViewController: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
