//
//  AddJobViewController.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 18/10/22.
//

import UIKit

class AddJobViewController: UIViewController {
    
    private let jobTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: 350, height: 24))
        label.textColor = .black
        label.text = "Judul Pekerjaan"
        return label
    }()
    
    private let jobTitleInput: UITextField = {
        let textField = UITextField(frame: CGRect(x: 10, y: 30, width: 350, height: 44))
//        textField.placeholder = "Placeholder text"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let jobDescriptionLabel: UILabel = {
       let label = UILabel(frame: CGRect(x: 10, y: 90, width: 350, height: 24))
        label.textColor = .black
        label.text = "Deskripsi Pekerjaan"
        
        return label
    }()
    
    private let jobDescriptionInput: UITextView = {
        let textView = UITextView(frame: CGRect(x: 10, y: 118, width: 350, height: 100))
        textView.backgroundColor = UIColor(named: "LightGray")
        textView.layer.cornerRadius = 10
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return textView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 230, width: 350, height: 24))
        label.textColor = .black
        label.text = "Pilih Kategori"
        
        return label
    }()
    
    private let categoryInput: UITextField = {
        let textField = UITextField(frame: CGRect(x: 10, y: 260, width: 350, height: 44))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        textField.placeholder = "Pilih Kategori"
        
        return textField
    }()
    
    private let jobDurationLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 320, width: 350, height: 24))
        label.textColor = .black
        label.text = "Durasi Pekerjaan"
        
        return label
    }()
    
    private let jobDurationInput: UITextField = {
        let textField = UITextField(frame: CGRect(x: 10, y: 350, width: 350, height: 44))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 410, width: 350, height: 24))
        label.textColor = .black
        label.text = "Lokasi"
        
        return label
    }()
    
    private let locationInput: UITextField = {
        let textField = UITextField(frame: CGRect(x: 10, y: 440, width: 350, height: 44))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let feeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 500, width: 350, height: 24))
        label.textColor = .black
        label.text = "Bayaran"
        
        return label
    }()
    
    private let feeInput: UITextField = {
        let textField = UITextField(frame: CGRect(x: 10, y: 530, width: 350, height: 44))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let contactLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 590, width: 350, height: 24))
        label.textColor = .black
        label.text = "Nomor Whatsapp"
        
        return label
    }()
    
    private let contactInput: UITextField = {
        let textField = UITextField(frame: CGRect(x: 10, y: 620, width: 350, height: 44))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let jobDateLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 680, width: 350, height: 24))
        label.textColor = .black
        label.text = "Waktu Pengerjaan"
        
        return label
    }()
    
    private let jobDateInput: UITextField = {
        let textField = UITextField(frame: CGRect(x: 10, y: 710, width: 350, height: 44))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: "LightGray")
        
        return textField
    }()
    
    private let createButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 800, width: 350, height: 44))
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
        
        let scrollView: UIScrollView = {
            let scrollView = UIScrollView(frame: CGRect(x: 10, y: 120, width: view.frame.size.width - 20, height: view.frame.size.height - 20))
//            scrollView.backgroundColor = .red
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            
            return scrollView
        }()
        
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.size.width - 20, height: 1050)
        scrollView.addSubview(jobTitleLabel)
        scrollView.addSubview(jobTitleInput)
        scrollView.addSubview(jobDescriptionLabel)
        scrollView.addSubview(jobDescriptionInput)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(categoryInput)
        scrollView.addSubview(jobDurationLabel)
        scrollView.addSubview(jobDurationInput)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(locationInput)
        scrollView.addSubview(feeLabel)
        scrollView.addSubview(feeInput)
        scrollView.addSubview(contactLabel)
        scrollView.addSubview(contactInput)
        scrollView.addSubview(jobDateLabel)
        scrollView.addSubview(jobDateInput)
        scrollView.addSubview(createButton)
    }
}
