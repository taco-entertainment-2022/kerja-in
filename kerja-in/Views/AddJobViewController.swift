//
//  AddJobViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 18/10/22.
//

import UIKit
import DropDown

class AddJobViewController: UIViewController {
    
    private let textFieldWidth = 350
    private let textFieldHeight = 44
    private let cornerRadius = 10.0
    private let labelSize = 18.0
    
    private let dropDown = DropDown()
    
    let backButton = UIButton(type: .custom)
    
    var durationInputLabelValue: String = "Durasi"
    var category: String = ""

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
        stackView.distribution = .equalCentering
        
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
        label.font = UIFont.Outfit(.semiBold, size: labelSize)
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
        textField.font = UIFont.Outfit(.medium, size: labelSize)
        
        return textField
    }()
    
    private lazy var jobDescriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: labelSize)
        label.text = "Deskripsi Pekerjaan"
        
        return label
    }()
    
    private lazy var jobDescriptionInput: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(named: "LightGray")
        textView.layer.cornerRadius = cornerRadius
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.delegate = self
        textView.returnKeyType = .continue
        textView.font = UIFont.Outfit(.medium, size: labelSize)
        
        return textView
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: labelSize)
        label.text = "Pilih Kategori"
        
        return label
    }()
    
    private lazy var categoryInputLabel: UILabel = {
        let label = UILabel()
        label.text = "Pilih Kategori"
        label.textAlignment = .left
        label.textColor = UIColor(named: "DetailsGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.Outfit(.medium, size: labelSize)
        
        return label
    }()
    
    private lazy var categoryInput: UIView = {
        let view = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCategory))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(named: "LightGray")
        view.layer.cornerRadius = cornerRadius
        
        view.addSubview(categoryInputLabel)
        
        return view
    }()
    
    private lazy var jobDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: labelSize)
        label.text = "Durasi Pekerjaan"
        
        return label
    }()
    
    lazy var jobDurationInputLabel: UILabel = {
        let label = UILabel()
        label.text = durationInputLabelValue
        label.textAlignment = .left
        label.textColor = UIColor(named: "DetailsGray")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.Outfit(.medium, size: labelSize)
        
        return label
    }()
    
    private lazy var jobDurationInput: UIView = {
        let view = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDuration))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(named: "LightGray")
        view.layer.cornerRadius = cornerRadius
        
        view.addSubview(jobDurationInputLabel)
        
        return view
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: labelSize)
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
        label.font = UIFont.Outfit(.semiBold, size: labelSize)
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
        label.font = UIFont.Outfit(.semiBold, size: labelSize)
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
        label.font = UIFont.Outfit(.semiBold, size: labelSize)
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
        button.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
        
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkWhite")
        self.title = "Add Job"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "DarkBlue")
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.Outfit(.semiBold, size: 20)]
        
        navigationController?.navigationBar.tintColor = UIColor(named: "White")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 31, height: 31)
        backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: backButton)
        self.navigationItem.setLeftBarButtonItems([item1], animated: true)
            
        setUpViews()
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
        
        categoryInputLabel.snp.makeConstraints { (make) in
            make.left.equalTo(categoryInput.snp.left).offset(10)
            make.centerY.equalTo(categoryInput.snp.centerY)
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
        
        jobDurationInputLabel.snp.makeConstraints { (make) in
            make.left.equalTo(jobDurationInput.snp.left).offset(10)
            make.centerY.equalTo(jobDurationInput.snp.centerY)
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
    
    @objc func backPressed() {
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapCategory() {
        dropDown.dataSource = ["Responden", "Jasa Setir", "Titip Beli", "Foto Model", "Sales", "MC", "Riset", "Lainnya"]
        dropDown.anchorView = categoryInput
        dropDown.bottomOffset = CGPoint(x: 0, y: categoryInput.frame.size.height)
        dropDown.show()
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            AddJobViewViewModel.shared.category = item
            category = item
            categoryInputLabel.text = item
            categoryInputLabel.textColor = .black
            categoryInputLabel.font = UIFont.Outfit(.regular, size: labelSize)
        }
    }
    
    @objc private func didTapDuration() {
        print("Duration pressed")
        let durationPicker = DurationPickerViewController()
        if let sheet = durationPicker.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        
        present(durationPicker, animated: true, completion: nil)
    }
    
    @objc func didTapCreate() {
        createButton.resignFirstResponder()
        AddJobViewViewModel.shared.jobTitle = jobTitleInput.text!
        AddJobViewViewModel.shared.jobDescription = jobDescriptionInput.text!
//        AddJobViewViewModel.shared.jobDuration = jobDurationInput.text!
        AddJobViewViewModel.shared.location = locationInput.text!
        AddJobViewViewModel.shared.fee = feeInput.text!
        AddJobViewViewModel.shared.contact = contactInput.text!
        AddJobViewViewModel.shared.jobDate = jobDateInput.text!
        
        print(jobTitleInput.text!, jobDescriptionInput.text!, locationInput.text!, feeInput.text!, contactInput.text!, jobDateInput.text!)
    }
}

extension AddJobViewController: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
