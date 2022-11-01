//
//  ProfileViewController.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 30/09/22.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import LBTAComponents


struct Section {
    let title: String
    let option: [SettingOption]
}

struct SettingOption {
    let title: String
    let handler: (() -> Void)
}

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let profileImageViewHeight: CGFloat = 56
    lazy var profileImageView: CachedImageView = {
        var iv = CachedImageView()
        iv.backgroundColor = .blue
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = profileImageViewHeight / 2
        iv.clipsToBounds = true

        return iv
    }()
//
//    private lazy var profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 35
//        imageView.backgroundColor = .red
//        imageView
//        return imageView
//    }()
//
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User's Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
       
        return label
    }()

    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
       
        return label
    }()
    
    
    private let  tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        return table
    }()
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 6, width: 350, height: 79))
        view.backgroundColor = UIColor(named: "White")
        return view
    }()
    
    let editButton: UIButton = {
        
        let button = UIButton(type: .system)
        //button.setTitle("Masuk", for: .normal)
        button.setImage(UIImage(named: "edit"), for: .normal)
        //button.backgroundColor = .red
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        //button.setTitleColor(.black, for: .normal)
        //button.backgroundColor = UIColor.buttonColor()
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        //button.layer.cornerRadius = 20
        
        return button
        
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkWhite")

        loadData()
        configure()
        
        
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 200, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: profileImageViewHeight, height: profileImageViewHeight)
        
        view.addSubview(nameLabel)
        nameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 24, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
        view.addSubview(phoneLabel)
        phoneLabel.anchor(top: nameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
        
   
        view.addSubview(editButton)
        editButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 34, width: 16, height: 16)
        
        tableView.frame = self.view.frame
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "DarkBlue")
        
        // Customizing navigation bar
        navigationController?.navigationBar.tintColor = UIColor(named: "White")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backButtonTitle = ""

    }
    
    func configure() {
        models.append(Section(title: "File Saya", option: [
            SettingOption(title: "Job Posted") {
                print("Tapped First Cell")
            },
            SettingOption(title: "Saved Jobs") {
                
            },
            
        ]))
        
        
        models.append(Section(title: "Support", option: [
            SettingOption(title: "FAQ") {
                
            },
            SettingOption(title: "Tutorial") {
                
            },
            SettingOption(title: "Ulas Aplikasi") {
                
            },
            SettingOption(title: "Report") {
                
            },
            SettingOption(title: "Mengenai Kerjaan") {
                
            },
            
        ]))
        
        models.append(Section(title: "", option: [
            SettingOption(title: "Sign Out") {
               
                UserDefaults.standard.set(false, forKey: "userLoggedIn")
                UserDefaults.standard.synchronize()
                
                
                do {
                    try Auth.auth().signOut()
                    
                    let navVC = UINavigationController(rootViewController: ProfileViewController())
                    navVC.modalPresentationStyle = .fullScreen
                    //navVC.modalTransitionStyle = .coverVertical
                    self.present(navVC, animated: false) {
                        navVC.pushViewController(LoginController(), animated: false)
                    }
                    
                    
                } catch let error {
                    print("Failed to sign out with error...", error)
                }
                
            },
            
        ]))
    }
    
    @objc func handleEdit() {
        
        navigationController?.pushViewController(editProfileController(), animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return models[section].option.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section].option[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].option[indexPath.row]
        model.handler()
    }
    
    func loadData() {

        let db = Firestore.firestore()
        if let userId = Auth.auth().currentUser?.uid {

        var userName = db.collection("user").getDocuments() { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                
                if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
                    let userName = currentUserDoc["firstname"] as! String
                    let phoneNumber = currentUserDoc["phone"] as! String
                    
                    self.nameLabel.text = userName
                    self.phoneLabel.text = phoneNumber
                }
            }
        }
        }
    }
    
    
}
