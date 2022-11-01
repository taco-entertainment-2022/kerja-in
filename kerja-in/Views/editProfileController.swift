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
        return tf.textField(withPlaceholder: "Nama Lengkap", isSecureTextEntry: false)
    }()
    
    lazy var phoneTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceholder: "Nomor Telepon", isSecureTextEntry: false)
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceholder: "Email", isSecureTextEntry: false)
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceholder: "Password", isSecureTextEntry: false)
    }()
    
    lazy var rePasswordTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceholder: "Re-Password", isSecureTextEntry: false)
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)

        button.setTitle("Ganti", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.buttonColor()
        button.addTarget(self, action: #selector(handleSaveProfile), for: .touchUpInside)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        handleFetchUserButtonTapped()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewComponents()
        loadData()
    }

 
    
    @objc func handleSaveProfile() {
        
//        let currentUser = Auth.auth().currentUser
//
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//
//        let ref = Database.database().reference().child("user")
//
//        let values = ["firstname": nameTextField.text ?? "", "email": emailTextField.text ?? ""]
//        ref.child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
//            if (error != nil) {
//                print("error")
//                return
//            }
//            print("Value Update")
//
//            currentUser?.updateEmail(to: self.emailTextField.text!) { error in
//                if let error = error {
//                    print(error)
//                } else {
//                    print("CHANGED")
//                    let uid = Auth.auth().currentUser!.uid
//                    let thisUserRef = Database.database().reference().child("users").child(uid)
//                    let thisUserEmailRef = thisUserRef.child("email")
//                    thisUserEmailRef.setValue(self.emailTextField.text!)
//                }
//            }
//        })
        
        let db = Firestore.firestore()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userEmail = Auth.auth().currentUser?.email
        let currentUser = Auth.auth().currentUser
        
//        if nameTextField.text != nil && emailTextField.text != nil && phoneTextField.text != nil {
//            db.collection("user").document("\(userID)").updateData(["firstname": nameTextField.text!, "email": emailTextField.text!, "phone": phoneTextField.text!] )
        let userRef = db.collection("user").document(userID)
        userRef.updateData(["email": emailTextField.text, "firstname": nameTextField.text!, "phone": phoneTextField.text!]) { (error) in
            if error == nil {
                print("UPDATED")
                
                if self.emailTextField.text != userEmail {
                    currentUser?.updateEmail(to: self.emailTextField.text!) { error in
                        if let error  = error {
                            print(error)
                        }
                    }
                }
                
            } else {
                print("NOT UPDATED")
            }
        }
        
        
      
        
        //}
    }
    
    @objc func handleFetchUserButtonTapped() {
        
        if Auth.auth().currentUser != nil {
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            Database.database().reference().child("user").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dict = snapshot.value as? [String: Any] else {return}
                
                let user = CurrentUser(uid: uid, dictionary: dict)
                
                //self.nameLabel.text = user.name
                //self.phoneLabel.text = user.phone
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
//        if let userId = Auth.auth().currentUser?.uid {
//
//        var userName = db.collection("user").getDocuments() { (snapshot, error) in
//            if let error = error {
//                print("Error getting documents: \(error)")
//            } else {
//
//                if let currentUserDoc = snapshot?.documents.first(where: { ($0["uid"] as? String) == userId }) {
//                    let userName = currentUserDoc["firstname"] as! String
//                    let phoneNumber = currentUserDoc["phone"] as! String
//                    let email = currentUserDoc["email"] as! String
//
//                    self.nameTextField.text = userName
//                    self.phoneTextField.text = phoneNumber
//                    self.emailTextField.text = email
        
        guard let userUID = Auth.auth().currentUser?.uid else { return  }
        db.collection("user").document(userUID).getDocument { snapshot, error in
            if error != nil {
                print("ERROR FETCh")
            }
            else {
                let userName = snapshot?.get("firstname") as! String
                let phoneNumber = snapshot?.get("phone") as! String
                let email = snapshot?.get("email") as! String
                
                self.nameTextField.text = userName
                self.phoneTextField.text = phoneNumber
                self.emailTextField.text = email
                }
//            }
//        }
    }
    }

    func configureViewComponents() {
        
        view.backgroundColor = UIColor.backgroundColor()
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(nameContainerView)
        nameContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 140, paddingLeft: 20, paddingBottom: 0, paddingRight: 21, width: 0, height: 43)
        
        view.addSubview(phoneContainerView)
        phoneContainerView.anchor(top: nameContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 21, width: 0, height: 43)
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: phoneContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 21, width: 0, height: 43)

        view.addSubview(passwordContainerView)
        passwordContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 21, width: 0, height: 43)
        
        view.addSubview(rePasswordContainerView)
        rePasswordContainerView.anchor(top: passwordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 21, width: 0, height: 43)

        view.addSubview(loginButton)
        loginButton.anchor(top: rePasswordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 50)

    }


}
