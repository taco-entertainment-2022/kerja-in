//
//  AddJobViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 18/10/22.
//

import UIKit
import DropDown
import FirebaseFirestore
import Combine

class AddJobViewController: UIViewController {
    
    private let textFieldWidth = 350
    private let textFieldHeight = 44
    private let cornerRadius = 10.0
    private let labelSize = 18.0
    private let inputFontSize = 16.0
    private let offsetLabelToTextfield = 8.0
    private let offsetTextfieldToLabel = 20.0
    private let paddings = 10.0
    
    private let dropDown = DropDown()    
    private let numOption = Array(1...60)
    private let durationOption = ["Menit", "Jam", "Hari", "Bulan", "Tahun"]
    
    let backButton = UIButton(type: .custom)
    let database = Firestore.firestore()
    var category: String = ""
    var duration: String = ""
    var jobDate: String = ""
        
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
        textField.layer.cornerRadius = cornerRadius
        textField.font = UIFont.Outfit(.regular, size: inputFontSize)
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.delegate = self
        textField.autocapitalizationType = .words
        textField.returnKeyType = .continue
        textField.setPadding(left: paddings, right: paddings)
        textField.becomeFirstResponder()
        
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
        textView.font = UIFont.Outfit(.regular, size: inputFontSize)
        textView.textColor = UIColor(named: "Black")
        
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
        
    private lazy var categoryInput: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "LightGray")
        button.layer.cornerRadius = cornerRadius
        button.titleLabel?.font = UIFont.Outfit(.medium, size: inputFontSize)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets.left = 8
        button.setTitleColor(UIColor(named: "GuideGray"), for: .normal)
        button.addTarget(self, action: #selector(didTapCategory), for: .touchUpInside)
        button.setTitle("Pilih Kategori", for: .normal)
        
        return button
    }()
    
    private lazy var jobDurationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.Outfit(.semiBold, size: labelSize)
        label.text = "Durasi Pekerjaan"
        
        return label
    }()
        
    lazy var jobDurationInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = cornerRadius
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.delegate = self
        textField.autocapitalizationType = .words
        textField.returnKeyType = .continue
        textField.becomeFirstResponder()
        textField.attributedPlaceholder = NSAttributedString(string: "Durasi", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.medium, size: 16), NSAttributedString.Key.foregroundColor: UIColor(named: "GuideGray")!])
        textField.font = UIFont.Outfit(.regular, size: inputFontSize)
        textField.textColor = UIColor(named: "Black")
        textField.setPadding(left: paddings, right: paddings)
        
        return textField
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
        textField.layer.cornerRadius = cornerRadius
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.attributedPlaceholder = NSAttributedString(string: "Pilih Lokasi", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.medium, size: 16), NSAttributedString.Key.foregroundColor: UIColor(named: "GuideGray")!])
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.font = UIFont.Outfit(.regular, size: inputFontSize)
        textField.textColor = UIColor(named: "Black")
        textField.setPadding(left: paddings, right: paddings)
        
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
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.keyboardType = .numberPad
        textField.font = UIFont.Outfit(.regular, size: inputFontSize)
        textField.textColor = UIColor(named: "Black")
        textField.layer.cornerRadius = cornerRadius
        textField.setPadding(left: paddings, right: paddings)
        
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
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.delegate = self
        textField.returnKeyType = .continue
        textField.keyboardType = .phonePad
        textField.font = UIFont.Outfit(.regular, size: inputFontSize)
        textField.textColor = UIColor(named: "Black")
        textField.layer.cornerRadius = cornerRadius
        textField.setPadding(left: paddings, right: paddings)
        
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
    
    lazy var jobDateInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = cornerRadius
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.delegate = self
        textField.autocapitalizationType = .words
        textField.returnKeyType = .continue
        textField.becomeFirstResponder()
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.medium, size: 16), NSAttributedString.Key.foregroundColor: UIColor(named: "GuideGray")!])
        textField.font = UIFont.Outfit(.regular, size: inputFontSize)
        textField.textColor = UIColor(named: "Black")
        textField.setPadding(left: paddings, right: paddings)
        
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
        
    private lazy var durationPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .white
        
        return pickerView
    }()
    
    private lazy var jobDatePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = .white
//        datePicker.setValue(UIColor.white, forKey: "backgroundColor")
        datePicker.preferredDatePickerStyle = .wheels
        
        let localDate = Locale(identifier: "id")
        datePicker.locale = localDate
        datePicker.datePickerMode = .dateAndTime
        
        return datePicker
    }()
    
    private var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(named: "DarkBlue")
        toolBar.sizeToFit()
        
        return toolBar
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
        connectDurationInput()
        connectJobDateInput()
        
        let docRef = database.collection("jobs").document("posts")
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            
        }
        
    }
        
    private func setUpViews() {
        //styling
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
            make.top.equalTo(jobTitleLabel.snp.bottom).offset(offsetLabelToTextfield)
        }
        
        jobDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobTitleInput.snp.bottom).offset(offsetTextfieldToLabel)
        }
        
        jobDescriptionInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobDescriptionLabel.snp.bottom).offset(offsetLabelToTextfield)
        }
        
        categoryLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobDescriptionInput.snp.bottom).offset(offsetTextfieldToLabel)
        }
        
        categoryInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(categoryLabel.snp.bottom).offset(offsetLabelToTextfield)
        }
        
        jobDurationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(categoryInput.snp.bottom).offset(offsetTextfieldToLabel)
        }
        
        jobDurationInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobDurationLabel.snp.bottom).offset(offsetLabelToTextfield)
        }
        
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobDurationInput.snp.bottom).offset(offsetTextfieldToLabel)
        }
        
        locationInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(locationLabel.snp.bottom).offset(offsetLabelToTextfield)
        }
        
        feeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(locationInput.snp.bottom).offset(offsetTextfieldToLabel)
        }
        
        feeInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(feeLabel.snp.bottom).offset(offsetLabelToTextfield)
        }
        
        contactLabel.snp.makeConstraints { (make) in
            make.top.equalTo(feeInput.snp.bottom).offset(offsetTextfieldToLabel)
        }
        
        contactInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(contactLabel.snp.bottom).offset(offsetLabelToTextfield)
        }
        
        jobDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contactInput.snp.bottom).offset(offsetTextfieldToLabel)
        }
        
        jobDateInput.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(jobDateLabel.snp.bottom).offset(offsetLabelToTextfield)
        }
        
        createButton.snp.makeConstraints { (make) in
            make.width.equalTo(textFieldWidth)
            make.height.equalTo(textFieldHeight)
            make.centerX.equalToSuperview()
        }
    }
    
    func connectDurationInput() {
        durationPickerView.delegate = self
        durationPickerView.dataSource = self
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePickerDidTap))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePickerDidTap))
        
        toolBar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        jobDurationInput.inputView = durationPickerView
        jobDurationInput.inputAccessoryView = toolBar
    }
    
    func connectJobDateInput() {
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePickerDidTap))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePickerDidTap))
        
        toolBar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        jobDatePickerView.addTarget(self, action: #selector(jobDatePickerViewChanged), for: .valueChanged)
        jobDateInput.inputView = jobDatePickerView
        jobDateInput.inputAccessoryView = toolBar
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
            AddJobViewViewModel.shared.category = item
            categoryInput.titleLabel?.textColor = UIColor.init(named: "Black")
            categoryInput.titleLabel?.font = UIFont.Outfit(.medium, size: 16)
            categoryInput.setTitle(item, for: .normal)
        }
    }
    
    @objc func donePickerDidTap() {
            view.endEditing(true)
    }
    
    @objc func jobDatePickerViewChanged() {
        let dateFormat = DateFormatter()
        dateFormat.locale = Locale(identifier: "id-ID")
        dateFormat.dateFormat = "EEE, dd-MM-yyyy hh:mm"
        jobDate = dateFormat.string(from: jobDatePickerView.date)
        jobDateInput.text = "\(jobDate)"
    }
    
    @objc func didTapCreate() {
        createButton.resignFirstResponder()
        AddJobViewViewModel.shared.jobTitle = jobTitleInput.text!
        AddJobViewViewModel.shared.jobDescription = jobDescriptionInput.text!
        AddJobViewViewModel.shared.jobDuration = jobDurationInput.text!//jobDurationInput.titleLabel?.text!
        AddJobViewViewModel.shared.location = locationInput.text!
        AddJobViewViewModel.shared.fee = feeInput.text!
        AddJobViewViewModel.shared.contact = contactInput.text!
        AddJobViewViewModel.shared.jobDate = jobDateInput.text ?? ""
        
        if !jobDateInput.text!.isEmpty &&
            !jobDescriptionInput.text.isEmpty &&
            !jobDurationInput.text!.isEmpty &&
            !jobTitleInput.text!.isEmpty &&
            !locationInput.text!.isEmpty &&
            !feeInput.text!.isEmpty &&
            (category.count == 0 || category == "") &&
            !contactInput.text!.isEmpty {
            AddJobViewViewModel.shared.saveData(date: AddJobViewViewModel.shared.jobDate ?? "",
                                                description: AddJobViewViewModel.shared.jobDescription!,
                                                jobName: AddJobViewViewModel.shared.jobTitle!,
                                                location: AddJobViewViewModel.shared.location!,
                                                price: AddJobViewViewModel.shared.fee!,
                                                userImage: AddJobViewViewModel.shared.category!,
                                                userContact: AddJobViewViewModel.shared.contact!,
                                                userID: AddJobViewViewModel.shared.userID!,
                                                jobDuration: AddJobViewViewModel.shared.jobDuration!)
            self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
}

extension UITextField {
    func setPadding(left: CGFloat, right: CGFloat? = nil) {
        setLeftPadding(left)
        if let rightPadding = right {
            setRightPadding(rightPadding)
        }
    }
    
    private func setLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    private func setRightPadding(_ padding: CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
}

extension AddJobViewController: UITextViewDelegate, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddJobViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return numOption.count
        }
        
        return durationOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\(numOption[row])"
        }
        
        return "\(durationOption[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let numSelected = numOption[pickerView.selectedRow(inComponent: 0)]
        let durationSelected = durationOption[pickerView.selectedRow(inComponent: 1)]
        
        duration = "\(numSelected) \(durationSelected)"
        jobDurationInput.text = duration
    }
}
