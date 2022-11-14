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
import SnapKit
import SafariServices


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
//    lazy var profileImageView: CachedImageView = {
//        var iv = CachedImageView()
//        iv.backgroundColor = .blue
//        iv.contentMode = .scaleAspectFill
//        iv.layer.cornerRadius = 8
//        iv.clipsToBounds = true
//
//        return iv
//    }()
    let profileImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")

        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "User's Name"
        label.font = UIFont.Outfit(.medium, size: 20)
       
        return label
    }()

    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number"
        label.font = UIFont.Outfit(.light, size: 14)
        label.textColor = .black
       
        return label
    }()
    
    lazy var fileLabel: UILabel = {
        let label = UILabel()
        label.text = "File Saya"
        label.font = UIFont.Outfit(.semiBold, size: 20)
        
        return label
    }()
    
    lazy var supportLabel: UILabel = {
        let label = UILabel()
        label.text = "Support"
        label.font = UIFont.Outfit(.semiBold, size: 20)
        
        return label
    }()
    
    lazy var noAccountHeadLabel: UILabel = {
        let label = UILabel()
        label.text = "Anda belum punya akun... "
        label.font = UIFont.Outfit(.semiBold, size: 20)
        
        return label
    }()
    
    lazy var noAccountBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Daftarkan diri anda untuk dapat melamar dan menawarkan pekerjaan tambahan"
        label.font = UIFont.Outfit(.light, size: 15)
        label.numberOfLines = 0
        
        return label
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Daftar", for: .normal)
        
        button.titleLabel?.font = UIFont.Outfit(.medium, size: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.buttonColor()
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    private let  tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        return table
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "White")
        view.layer.cornerRadius = 10
        view.clipsToBounds = false

        //backView Shadow
        view.layer.shadowColor = UIColor(named: "Black")?.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 6
        view.layer.shadowOffset = CGSize(width: 1, height: 2)
        
  
        return view
    }()
    
    let editButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.tintColor = UIColor(named: "GuideGray")
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)

        return button
        
    }()
    
    let copyright: UIImageView = {
       
        let imageView = UIImageView()
        imageView.image = UIImage(named: "copyright")

        return imageView
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkWhite")

        loadData()
        configure()
        configureViewComponents()
        
        tableView.frame = self.view.frame
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.layer.shadowColor = UIColor(named: "Black")?.cgColor
        tableView.layer.shadowOpacity = 0.1
        tableView.layer.shadowRadius = 6
        tableView.layer.shadowOffset = CGSize(width: 1, height: 2)
        
        //MARK: - Set Navigation Bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "DarkBlue")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.Outfit(.semiBold, size: 20)]
        // Customizing navigation bar
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.backButtonTitle = ""

      
  
    }
    
    @objc func handleSignUp() {
//        navigationController?.pushViewController(SignUpController(), animated: false)
        
        let navVC = UINavigationController(rootViewController: TabBar())
        navVC.modalPresentationStyle = .fullScreen
        //navVC.modalTransitionStyle = .coverVertical
        self.present(navVC, animated: false) {
            navVC.pushViewController(SignUpController(), animated: false)
        }
    }
    
    func configure() {
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "userLoggedIn")
        
            
            if isLoggedIn == true{
             print("loggedIn")
                
                
                 view.addSubview(backView)
                 backView.snp.makeConstraints { make in
                     make.width.equalTo(350)
                     make.height.equalTo(79)
                     make.top.equalTo(109)
                     make.left.equalTo(20)
                     make.right.equalTo(-20)
                 }
                 
                 
                 view.addSubview(profileImageView)
                 profileImageView.snp.makeConstraints { make in
                     make.width.equalTo(59)
                     make.height.equalTo(59)
                     make.top.equalTo(119)
                     make.left.equalTo(31)
                     //make.right.equalTo(-300)
                 }
                 
                 view.addSubview(nameLabel)
                 nameLabel.snp.makeConstraints { make in
         //            make.width.equalTo(112)
                     make.height.equalTo(25)
                     make.top.equalTo(127)
                     make.left.equalTo(105)
         //            make.right.equalTo(-173)
                 }
                 
                 view.addSubview(phoneLabel)
                 phoneLabel.snp.makeConstraints { make in
                     make.top.equalTo(152)
                     make.left.equalTo(105)
                 }
            
                 view.addSubview(editButton)
                 editButton.snp.makeConstraints { make in
                     make.width.equalTo(16)
                     make.height.equalTo(16)
                     make.top.equalTo(141)
                     //make.left.equalTo(340)
                     make.right.equalTo(-34)
                 }
                
                view.addSubview(fileLabel)
                fileLabel.snp.makeConstraints { make in
                    make.width.equalTo(80)
                    make.height.equalTo(25)
                    make.top.equalTo(203)
                    make.left.equalTo(21)
                    make.right.equalTo(-287)
                }
                
                view.addSubview(supportLabel)
                supportLabel.snp.makeConstraints { make in
                    make.width.equalTo(74)
                    make.height.equalTo(25)
                    make.top.equalTo(338)
                    make.left.equalTo(20)
                    make.right.equalTo(-296)
                }
                
                view.addSubview(copyright)
                copyright.snp.makeConstraints { make in
                    make.width.equalTo(53)
                    make.height.equalTo(13)
                    make.top.equalTo(735)
                    make.leftMargin.equalTo(168)
                }

                models.append(Section(title:" ", option: [
                    SettingOption(title: "Pekerjaan Diposting") {
                        print("Tapped First Cell")
                        
                        self.navigationController?.pushViewController(JobsPostedViewController(), animated: true)
                    },
                    SettingOption(title: "Pekerjaan Disimpan") {
                        
                    },
                    
                ]))
                
                
                view.addSubview(tableView)
                tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 180, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
               
                
                models.append(Section(title:" ", option: [
                    SettingOption(title: "FAQ") {
                        
                        if let url = URL(string: "https://www.kerjainaja.com/faq/") {
                            let safariVC = SFSafariViewController(url: url)
                            self.present(safariVC, animated: true, completion: nil)
                        }
                        
                    },
                    SettingOption(title: "Tutorial") {
                        
                    },
                    SettingOption(title: "Ulas Aplikasi") {
                        
                    },
                    SettingOption(title: "Report") {
                        
                    },
                    SettingOption(title: "Mengenai Kerjain") {
                        
                        if let url = URL(string: "https://www.kerjainaja.com") {
                            let safariVC = SFSafariViewController(url: url)
                            self.present(safariVC, animated: true, completion: nil)
                        }
                        
                    },
                    
                ]))
                
                models.append(Section(title: "", option: [
                    SettingOption(title: "Keluar") {
                        
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
                
            }else{
             print("loggedOut")
                
                view.addSubview(backView)
                backView.snp.makeConstraints { make in
                    make.width.equalTo(350)
                    make.height.equalTo(139)
                    make.top.equalTo(107)
                    make.left.equalTo(20)
                    //make.right.equalTo(-296)
                }
                
                view.addSubview(noAccountHeadLabel)
                noAccountHeadLabel.snp.makeConstraints { make in
                    make.height.equalTo(25)
                    make.top.equalTo(120)
                    make.left.equalTo(78)
                    //make.right.equalTo(-296)
                }
                
                view.addSubview(noAccountBodyLabel)
                noAccountBodyLabel.snp.makeConstraints { make in
                    make.width.equalTo(316)
                    make.height.equalTo(38)
                    make.top.equalTo(150)
                    make.left.equalTo(37)
                    //make.right.equalTo(-296)
                }
                
                view.addSubview(signUpButton)
                signUpButton.snp.makeConstraints { make in
                    make.width.equalTo(114)
                    make.height.equalTo(35)
                    make.top.equalTo(198)
                    make.left.equalTo(138)
                    //make.right.equalTo(-296)
                }
                
                view.addSubview(supportLabel)
                supportLabel.snp.makeConstraints { make in
                    make.width.equalTo(74)
                    make.height.equalTo(25)
                    make.top.equalTo(257)
                    make.left.equalTo(20)
                    //make.right.equalTo(-296)
                }
                
                view.addSubview(copyright)
                copyright.snp.makeConstraints { make in
                    make.width.equalTo(53)
                    make.height.equalTo(13)
                    make.top.equalTo(735)
                    make.leftMargin.equalTo(168)
                }
                
                
                view.addSubview(tableView)
                tableView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 247, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
               
                
                models.append(Section(title:" ", option: [
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
                
            }
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

        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].option[indexPath.row]
        model.handler()
    }
    
    func loadData() {

        let db = Firestore.firestore()
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("user").document(userUID).getDocument { snapshot, error in
            if error != nil {
                print("ERROR FETCH")
            }
            else {
                let userName = snapshot?.get("firstname") as? String
                let phoneNumber = snapshot?.get("phone") as? String
                
                self.nameLabel.text = userName
                self.phoneLabel.text = phoneNumber
            }
        }
    }
    
    func configureViewComponents() {
        

        

        

    }
}
