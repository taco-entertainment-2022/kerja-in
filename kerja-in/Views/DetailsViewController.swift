//
//  DetailsViewController.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 11/10/22.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    
    var tableView = UITableView()
    var jobsArr = [JobModel]()
    var isOn: Bool = false
    let savedButton = UIButton(type: .custom)
    
    lazy var userImage: UIImageView = {
        let userImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 54, height: 54))
        userImage.contentMode = .scaleAspectFit
        return userImage
    }()
    lazy var jobLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 80, y: 8, width: view.frame.width, height: 25))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.semiBold, size: 20)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    lazy var daysLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 105, y: 31, width: view.frame.width, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DarkGray")
        return lbl
    }()
    lazy var descTitleLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 239, height: 12.65))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 20)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    lazy var descLabel: UITextView = {
        let lbl = UITextView(frame: CGRect(x: 0, y: 0, width: 351, height: 273))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.regular, size: 14)
        lbl.textColor = UIColor(named: "DarkGray")
        lbl.backgroundColor = UIColor.clear
        return lbl
    }()
    lazy var contactButton: UIButton = {
        let contactButton = UIButton(frame: CGRect(x: 0, y: 0, width: 350, height: 44))
        contactButton.backgroundColor = UIColor(named: "Green")
        contactButton.layer.cornerRadius = contactButton.frame.height / 2
        return contactButton
    }()
    lazy var contactButtonIcon: UIImageView = {
        let contactButtonIcon = UIImageView(frame: CGRect(x: 80, y: 10, width: 24.78, height: 24))
        contactButtonIcon.image = UIImage(named: "Phone")
        return contactButtonIcon
    }()
    lazy var contactButtonLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 114.2, height: 28.89))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 20)
        lbl.textColor = UIColor(named: "White")
        lbl.text = "Contact"
        return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkWhite")
        
        //Navigation Bar
        self.title = "Job Detail Page"
        savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        savedButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        savedButton.addTarget(self, action: #selector(savedButtonPressed), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: savedButton)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        
        userImage.image = UIImage(named: "People")
        jobLabel.text = "Interview Mahasiswa Rantau"
        daysLabel.text = "5 days ago, oleh Fredo Sembi"
        descTitleLabel.text = "Deskripsi Pekerjaan"
        descLabel.text = "Butuh respondent mahasiswa rantau ya... Wajib lapor sebelum ngisi respondent. Tujuannya supaya bisa konfirmasi dulu dan bisa dibayar. Hubungi WAnya yang tertera ya. \n\nKalau bisa mahasiswa rantau dari luar Jawa ya... terus baru menjalani kuliah semester2 awal."
        setupViews()
        setTableView()
    }
    
    @objc func savedButtonPressed() {
        print("Button Clicked")
        isOn.toggle()
        if isOn {
            savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    func setTableView() {
        tableView.frame = self.view.frame
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.clear
        self.view.addSubview(tableView)
        
        tableView.register(JobsTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
    
    func setupViews() {
        self.view.addSubview(userImage)
        self.view.addSubview(jobLabel)
        self.view.addSubview(daysLabel)
        self.view.addSubview(descTitleLabel)
        self.view.addSubview(descLabel)
        self.view.addSubview(contactButton)
        contactButton.addSubview(contactButtonIcon)
        contactButton.addSubview(contactButtonLabel)
        
        //Set constraints
        userImage.snp.makeConstraints { make in
            make.topMargin.leftMargin.equalTo(17)
            make.width.height.equalTo(54)
        }
        jobLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(25)
            make.topMargin.equalTo(25)
            make.leftMargin.equalTo(80)
        }
        daysLabel.snp.makeConstraints { make in
            make.width.equalTo(188)
            make.height.equalTo(18)
            make.topMargin.equalTo(48)
            make.leftMargin.equalTo(80)
        }
        descTitleLabel.snp.makeConstraints { make in
            make.width.equalTo(239)
            make.height.equalTo(25)
            make.topMargin.equalTo(352)
            make.left.equalTo(17)
            
        }
        descLabel.snp.makeConstraints { make in
            make.width.equalTo(351)
            make.height.equalTo(273)
            make.topMargin.equalTo(380)
            make.left.equalTo(13)
            make.right.equalTo(-13)
        }
        contactButton.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.topMargin.equalTo(620)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.bottom.equalTo(-14)
        }
        contactButtonIcon.snp.makeConstraints { make in
            make.width.equalTo(24.78)
            make.height.equalTo(24)
            make.topMargin.equalTo(10)
            make.leftMargin.equalTo(125)
            make.rightMargin.equalTo(-140)
            make.bottom.equalTo(-10)
        }
        contactButtonLabel.snp.makeConstraints { make in
            make.width.equalTo(114.2)
            make.height.equalTo(28.89)
            make.topMargin.equalTo(13)
            make.leftMargin.equalTo(160)
            make.rightMargin.equalTo(-140)
            make.bottom.equalTo(-10)
        }
        
    }
    
 
}

//MARK: - TableView Extension
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsArr.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? DetailsTableViewCell else {fatalError("Unable to create cell")}
//        cell.userImage.image = jobsArr[indexPath.row].userImage
//        cell.jobLabel.text = jobsArr[indexPath.row].jobName
//        cell.dateLabel.text = jobsArr[indexPath.row].date
//        cell.locationLabel.text = jobsArr[indexPath.row].location
//        cell.priceLabel.text = jobsArr[indexPath.row].price
//        cell.postedLabel.text = jobsArr[indexPath.row].posted
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
}



