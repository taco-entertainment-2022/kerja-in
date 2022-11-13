//
//  editProfileController.swift
//  Kerjain-Login
//
//  Created by Wilbert Devin Wijaya on 18/10/22.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseFirestore

class editProfileController: UIViewController {
    
    let viewConstraints = ViewConstraints()

    lazy var nameContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, nameTextField)
    }()
    
    lazy var phoneContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, phoneTextField)
    }()
    
    lazy var emailContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, emailTextField)
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, passwordTextField)
    }()
    
    lazy var rePasswordContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, rePasswordTextField)
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceholder: "", isSecureTextEntry: false)
    }()
    
    lazy var phoneTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceholder: "", isSecureTextEntry: false)
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceholder: "", isSecureTextEntry: false)
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceholder: "", isSecureTextEntry: false)
    }()
    
    lazy var rePasswordTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceholder: "", isSecureTextEntry: false)
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nama Lengkap"
        label.font = UIFont.Outfit(.semiBold, size: viewConstraints.labelSize)
        
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Nomor WhatsApp"
        label.font = UIFont.Outfit(.semiBold, size: viewConstraints.labelSize)
        
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.Outfit(.semiBold, size: viewConstraints.labelSize)
        
        return label
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password Lama"
        label.font = UIFont.Outfit(.semiBold, size: viewConstraints.labelSize)
        
        return label
    }()
    
    lazy var rePasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password Baru"
        label.font = UIFont.Outfit(.semiBold, size: viewConstraints.labelSize)
        
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)

        button.setTitle("Simpan", for: .normal)
        button.titleLabel?.font = UIFont.Outfit(.medium, size: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "DarkBlue")
        button.addTarget(self, action: #selector(handleSaveProfile), for: .touchUpInside)
        button.layer.cornerRadius = 20
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        loadData()
    }

    
    @objc func handleSaveProfile() {
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userEmail = Auth.auth().currentUser?.email
        let currentUser = Auth.auth().currentUser
        let userRef = db.collection("user").document(userID)
        
        userRef.updateData(["email": emailTextField.text, "firstname": nameTextField.text!, "phone": phoneTextField.text!]) { (error) in
            if error == nil {
                print("UPDATED")
                
                if self.emailTextField.text != userEmail {
                    currentUser?.updateEmail(to: self.emailTextField.text!) { error in
                        if let error  = error {
                            print(error)
                        }
                        
                        self.changePassword(email: userEmail!, currentPassword: self.passwordTextField.text!, newPassword: self.rePasswordTextField.text!) { (error) in
                            if error != nil {
                                print("ERROR CHANGE PASS")
                            }
                            else {
                                print("SUCCESS CHANGE PASS")
                            }
                        }
                    }
                }
                
            } else {
                print("NOT UPDATED")
            }
        }
    }
    
    @objc func handleFetchUserButtonTapped() {
        
        if Auth.auth().currentUser != nil {
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            Database.database().reference().child("user").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dict = snapshot.value as? [String: Any] else {return}
                
                let user = CurrentUser(uid: uid, dictionary: dict)
                
                self.nameTextField.text = user.name
                self.phoneTextField.text = user.phone
                self.emailTextField.text = user.email
                
                
            }, withCancel: { (err) in
                print(err)
            })
        }
    }
    
    func loadData() {
        
        let db = Firestore.firestore()
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("user").document(userUID).getDocument { snapshot, error in
            if error != nil {
                print("ERROR FETCh")
            }
            else {
                let userName = snapshot?.get("firstname") as? String
                let phoneNumber = snapshot?.get("phone") as? String
                let email = snapshot?.get("email") as? String
                
                self.nameTextField.text = userName
                self.phoneTextField.text = phoneNumber
                self.emailTextField.text = email
            }
        }
    }
    
    func changePassword(email: String, currentPassword: String, newPassword: String, completion: @escaping (Error?) -> Void) {
            let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
            Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (result, error) in
                if let error = error {
                    completion(error)
                }
                else {
                    Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
                        completion(error)
                    })
                }
            })
        }

    func configureViewComponents() {
        
        view.backgroundColor = UIColor(named: "DarkWhite")
        self.title = "Edit Profile"
        //navigationController?.navigationBar.isHidden = true
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.left.equalToSuperview().offset(viewConstraints.offsetSuperviewToContent)
        }
        
        view.addSubview(nameContainerView)
        nameContainerView.snp.makeConstraints { make in
            make.width.equalTo(viewConstraints.textFieldWidth)
            make.height.equalTo(viewConstraints.textFieldHeight)
            make.top.equalTo(nameLabel.snp.bottom).offset(viewConstraints.offsetLabelToTextfield)
            make.left.equalToSuperview().offset(viewConstraints.offsetSuperviewToContent)
        }
        
        view.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(nameContainerView.snp.bottom).offset(viewConstraints.offsetTextfieldToLabelType2)
            make.left.equalToSuperview().offset(viewConstraints.offsetSuperviewToContent)
        }
        
        view.addSubview(phoneContainerView)
        phoneContainerView.snp.makeConstraints { make in
            make.width.equalTo(viewConstraints.textFieldWidth)
            make.height.equalTo(viewConstraints.textFieldHeight)
            make.top.equalTo(phoneLabel.snp.bottom).offset(viewConstraints.offsetLabelToTextfield)
            make.left.equalToSuperview().offset(viewConstraints.offsetSuperviewToContent)
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneContainerView.snp.bottom).offset(viewConstraints.offsetTextfieldToLabelType2)
            make.left.equalToSuperview().offset(viewConstraints.offsetSuperviewToContent)
        }
        
        view.addSubview(emailContainerView)
        emailContainerView.snp.makeConstraints { make in
            make.width.equalTo(viewConstraints.textFieldWidth)
            make.height.equalTo(viewConstraints.textFieldHeight)
            make.top.equalTo(emailLabel.snp.bottom).offset(viewConstraints.offsetLabelToTextfield)
            make.left.equalToSuperview().offset(viewConstraints.offsetSuperviewToContent)
        }
        
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailContainerView.snp.bottom).offset(viewConstraints.offsetTextfieldToLabelType2)
            make.left.equalToSuperview().offset(viewConstraints.offsetSuperviewToContent)
        }
        
        view.addSubview(passwordContainerView)
        passwordContainerView.snp.makeConstraints { make in
            make.width.equalTo(viewConstraints.textFieldWidth)
            make.height.equalTo(viewConstraints.textFieldHeight)
            make.top.equalTo(passwordLabel.snp.bottom).offset(viewConstraints.offsetLabelToTextfield)
            make.left.equalToSuperview().offset(viewConstraints.offsetSuperviewToContent)
        }
        
        view.addSubview(rePasswordLabel)
        rePasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.bottom).offset(viewConstraints.offsetTextfieldToLabelType2)
            make.left.equalToSuperview().offset(viewConstraints.offsetSuperviewToContent)
        }
        
        view.addSubview(rePasswordContainerView)
        rePasswordContainerView.snp.makeConstraints { make in
            make.width.equalTo(viewConstraints.textFieldWidth)
            make.height.equalTo(viewConstraints.textFieldHeight)
            make.top.equalTo(rePasswordLabel.snp.bottom).offset(viewConstraints.offsetLabelToTextfield)
            make.left.equalToSuperview().offset(viewConstraints.offsetSuperviewToContent)
        }

        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(viewConstraints.textFieldWidth)
            make.height.equalTo(viewConstraints.textFieldHeight)
            make.top.equalTo(rePasswordContainerView.snp.bottom).offset(viewConstraints.offsetTextfieldToButton)
            make.left.equalToSuperview().offset(viewConstraints.offsetSuperviewToContent)
        }

    }


}
