////
////  HomeController.swift
////  Kerjain-Login
////
////  Created by Wilbert Devin Wijaya on 04/10/22.
////
//
//import UIKit
//import Firebase
//import FirebaseDatabase
//import FirebaseAuth
//import LBTAComponents
//
//class HomeController: UIViewController {
//    
//    //MARK: - Properties
//    
//    let profileImageViewHeight: CGFloat = 56
//    lazy var profileImageView: CachedImageView = {
//        var iv = CachedImageView()
//        iv.backgroundColor = .blue
//        iv.contentMode = .scaleAspectFill
//        iv.layer.cornerRadius = profileImageViewHeight / 2
//        iv.clipsToBounds = true
//        
//        return iv
//    }()
//    
//    let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "User's Name"
//        label.font = UIFont.boldSystemFont(ofSize: 18)
//       
//        return label
//    }()
//
//    let phoneLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Phone Number"
//        label.font = UIFont.boldSystemFont(ofSize: 14)
//        label.textColor = .lightGray
//       
//        return label
//    }()
//    
//    let emailLabel: UILabel = {
//        let label = UILabel()
//        label.text = "User's Email"
//        label.font = UIFont.boldSystemFont(ofSize: 14)
//        label.textColor = .lightGray
//       
//        return label
//    }()
//    
//    var welcomeLabel: UILabel = {
//        
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 28)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.alpha = 0
//        
//        return label
//    }()
//    
//    let editButton: UIButton = {
//        
//        let button = UIButton(type: .system)
//        //button.setTitle("Masuk", for: .normal)
//        button.setImage(UIImage(named: "edit"), for: .normal)
//        //button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
//        //button.setTitleColor(.black, for: .normal)
//        //button.backgroundColor = UIColor.buttonColor()
//        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
//        //button.layer.cornerRadius = 20
//        
//        return button
//        
//    }()
//    
//    //MARK: - Selectors
//    
//    @objc func handleSignOut() {
//
//        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
//        
//        alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (_) in
//            self.signOut()
//        }))
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(alertController, animated: true, completion: nil)
//    }
//    
//    @objc func handleEdit() {
//        
//        navigationController?.pushViewController(editProfileController(), animated: true)
//    }
//    
//    //MARK: - Init
//    override func viewWillAppear(_ animated: Bool) {
//        handleFetchUserButtonTapped()
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        authenticateUserAndConfigureView()
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Fetch User", style: .done, target: self, action: #selector(handleFetchUserButtonTapped))
//    }
//    
//    //MARK - API
//    @objc func handleFetchUserButtonTapped() {
//        
//        if Auth.auth().currentUser != nil {
//            
//            guard let uid = Auth.auth().currentUser?.uid else {return}
//            
//            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//                
//                guard let dict = snapshot.value as? [String: Any] else {return}
//                
//                let user = CurrentUser(uid: uid, dictionary: dict)
//                
//                self.nameLabel.text = user.name
//                self.phoneLabel.text = user.phone
//                
//            }, withCancel: { (err) in
//                print(err)
//            })
//        }
//    }
//    
////    func loadUserData() {
////        guard let uid = Auth.auth().currentUser?.uid else {return}
////
////        Database.database().reference().child("users").child(uid).child("username").observeSingleEvent(of: .value) { (snapshot) in
////            guard let username = snapshot.value as? String else {return}
////            self.welcomeLabel.text = "Welcome, \(username)"
////            UIView.animate(withDuration: 0.5, animations: {
////                self.welcomeLabel.alpha = 1
////            })
////
////        }
////
////    }
//    
//    
//    func signOut() {
//        
//        do {
//            try Auth.auth().signOut()
//            let navigation = UINavigationController(rootViewController: LoginController())
//            //let segue = LoginController()
//            navigation.navigationBar.barStyle = .black
//            navigation.modalPresentationStyle = .fullScreen
//            
//            self.present(navigation, animated: true, completion: nil)
//            //self.navigationController?.pushViewController(segue, animated: true)
//        } catch let error {
//            print("Failed to sign out with error...", error)
//        }
//    }
//    
//    func authenticateUserAndConfigureView() {
//        
//        if Auth.auth().currentUser == nil {
//            DispatchQueue.main.async {
//                let navigation = UINavigationController(rootViewController: LoginController())
//                //let segue = LoginController()
//                navigation.modalPresentationStyle = .fullScreen
//                navigation.modalTransitionStyle = .crossDissolve
//                navigation.popViewController(animated: true)
//                navigation.navigationBar.barStyle = .black
//                self.present(navigation, animated: true, completion: nil)
//                //self.navigationController?.pushViewController(segue, animated: true)
//            }
//        } else {
//            configureViewComponents()
////            loadUserData()
//        }
//    }
//    
//    //MARK: - Helper Function
//    
//    func configureViewComponents() {
//        
//        view.backgroundColor = .white
//        
//        navigationItem.title = "Firebase Login"
//        
//        
//        //navigationItem.leftBarButtonItems = UIBarButtonItem(image: #imageLiteral(resourceName: "chevron.backward"), style: .plain, target: self, action: #selector(handleSignOut))
//        //navigationItem.leftBarButtonItems?.tintColor = .white
//        
//       // navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleSignOut))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleSignOut))
//        
//        //navigationController?.navigationBar.barTintColor = UIColor.placeHolderColor()
//        
//        view.addSubview(welcomeLabel)
//        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        
//        
//        view.addSubview(profileImageView)
//        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: profileImageViewHeight, height: profileImageViewHeight)
//        
//        view.addSubview(nameLabel)
//        nameLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 24, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
//        
//        view.addSubview(phoneLabel)
//        phoneLabel.anchor(top: nameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
//        
//        view.addSubview(emailLabel)
//        emailLabel.anchor(top: phoneLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
//        
//        view.addSubview(editButton)
//        editButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 49, paddingLeft: 0, paddingBottom: 0, paddingRight: 34, width: 16, height: 16)
//    }
//}
//
//
