//
//  SignUpController.swift
//  Kerjain-Login
//
//  Created by Wilbert Devin Wijaya on 04/10/22.
//

import UIKit
import Firebase
import AuthenticationServices
import GoogleSignIn
import FirebaseFirestore

class SignUpController: UIViewController {
    
    //MARK: - Properties
    lazy var titleTextView: UILabel = {
        let text = UILabel()
        return text.displayText(withPlaceholder: "Daftar", font: UIFont.Outfit(.semiBold, size: 32), color: .black, isSecureTextEntry: false)
    }()
    
    lazy var bodyTextView: UILabel = {
        let text = UILabel()
        return text.displayText(withPlaceholder: "Daftarkan diri anda untuk dapat melamar dan menawarkan pekerjaan tambahan", font: UIFont.Outfit(.light, size: 16), color: UIColor.placeHolderColor(),isSecureTextEntry: false)
    }()
 
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
    
    var iconClick = true
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.Outfit(.medium, size: 16)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.textFieldColor()
        textField.isSecureTextEntry = true
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolderColor()])
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        let btnPassword = UIButton(frame: CGRect(x: 12.5, y: 12.5, width: 25, height: 25))
        btnPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        btnPassword.contentMode = .scaleAspectFit
        btnPassword.addTarget(self, action: #selector(passwordButtonPressed), for: .touchUpInside)
        btnPassword.tintColor = UIColor.placeHolderColor()
        
        let separatorView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
        separatorView.addSubview(btnPassword)
        textField.rightViewMode = .always
        textField.rightView = separatorView
        
        
        return textField
    }()

    lazy var rePasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.Outfit(.medium, size: 16)
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.textFieldColor()
        textField.isSecureTextEntry = true
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "Re-Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeHolderColor()])
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        
        let btnPassword = UIButton(frame: CGRect(x: 12.5, y: 12.5, width: 25, height: 25))
        btnPassword.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        btnPassword.contentMode = .scaleAspectFit
        btnPassword.addTarget(self, action: #selector(rePasswordButtonPressed), for: .touchUpInside)
        btnPassword.tintColor = UIColor.placeHolderColor()
        
        let separatorView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
        separatorView.addSubview(btnPassword)
        textField.rightViewMode = .always
        textField.rightView = separatorView
        
        
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Daftar", for: .normal)
        
        button.titleLabel?.font = UIFont.Outfit(.medium, size: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.buttonColor()
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    let dontHaveAccount: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Sudah memiliki akun? ", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.light, size: 16), NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Masuk", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.medium, size: 16), NSAttributedString.Key.foregroundColor: UIColor.black]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)

        return button
    }()
    
    let seperator: UIImageView = {
       
        let imageView = UIImageView()
        imageView.image = UIImage(named: "seperator")
        imageView.alpha = 0.87
        
        return imageView
    }()
    
    let checkbox1 = CheckboxButton(frame: CGRect(x: 70, y: 200, width: 40, height: 40 ))
    func termsLabel() {
        
//        let label = UILabel()//frame: CGRect(x: 115, y: 200, width: 200, height: 40))
//        label.text = "Saya setuju dengan perjanjian syarat dan ketentuan."
//        label.font = UIFont.Outfit(.light, size: 15)
//        label.numberOfLines = 0
        
        let label: UIButton = {
            let button = UIButton(type: .system)
            let attributedTitle = NSMutableAttributedString(string: "Saya setuju dengan perjanjian ", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.light, size: 16), NSAttributedString.Key.foregroundColor: UIColor.black])
            attributedTitle.append(NSAttributedString(string: "syarat dan ketentuan", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.medium, size: 16), NSAttributedString.Key.foregroundColor: UIColor.black]))
            button.setAttributedTitle(attributedTitle, for: .normal)
            //button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
            button.titleLabel?.numberOfLines = 0
            return button
        }()
        
        view.addSubview(checkbox1)
        checkbox1.snp.makeConstraints { make in
            make.width.equalTo(15)
            make.height.equalTo(15)
            make.leftMargin.equalTo(21)
            make.bottom.equalTo(-368)

          
        }
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.width.equalTo(290)
            make.height.equalTo(38)
            make.leftMargin.equalTo(35)
            make.bottom.equalTo(-349)

          
        }
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
        checkbox1.addGestureRecognizer(gesture)
        
    }
    
    @objc func didTapCheckbox() {
        checkbox1.toggle()
        
        if checkbox1.checkmark.isHidden{
            print("checked")
            loginButton.isUserInteractionEnabled = false
        } else {
            print("Not Checked")
            loginButton.isUserInteractionEnabled = true
        }
    }
    
    func appleLoginButton() {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(handleAppleLogin), for: .touchUpInside)
        button.center = view.center
        view.addSubview(button)
  
        button.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(44)
            make.leftMargin.equalTo(21)
            make.bottom.equalTo(-146)
        }
        
    }
    
    let googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Daftar menggunakan Google", for: .normal)
        button.setImage(UIImage(named: "google"), for: .normal)
        button.imageView?.anchor(top: nil, left: nil , bottom: nil, right: button.titleLabel?.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 4, width: 16, height: 16)
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        button.titleLabel?.font = UIFont.Outfit(.medium, size: 16)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
      
        button.titleLabel?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true

        
        button.layer.cornerRadius = 8
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSizeMake(0, 0)
        return button
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
        appleLoginButton()
        
        termsLabel()
        
        if checkbox1.checkmark.isHidden {
            loginButton.isUserInteractionEnabled = true
        }
        

    }
    
    //MARK: - Selectors
    
    @objc func passwordButtonPressed(sender: UIButton){
        let passwordHideImage = UIImage(systemName: "eye.slash")
        let passwordVisibleImage = UIImage(systemName: "eye")
        
        iconClick = !iconClick
        if iconClick == false {
            passwordTextField.isSecureTextEntry = false
            sender.setImage(passwordVisibleImage, for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            sender.setImage(passwordHideImage, for: .normal)
        }
    }
    
    @objc func rePasswordButtonPressed(sender: UIButton){
        let passwordHideImage = UIImage(systemName: "eye.slash")
        let passwordVisibleImage = UIImage(systemName: "eye")
        
        iconClick = !iconClick
        if iconClick == false {
            rePasswordTextField.isSecureTextEntry = false
            sender.setImage(passwordVisibleImage, for: .normal)
        } else {
            rePasswordTextField.isSecureTextEntry = true
            sender.setImage(passwordHideImage, for: .normal)
        }
    }
    
    
    
    @objc func handleSignUp() {

        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let username = nameTextField.text else {return}
        guard let phone = phoneTextField.text else {return}
        
        createUser(withEmail: email, password: password, username: username, phone: phone)
    }
    
    @objc func handleShowLogin() {
        //navigationController?.popViewController(animated: true)
        let navVC = UINavigationController(rootViewController: LoginController())
        navVC.modalPresentationStyle = .fullScreen
        navVC.modalTransitionStyle = .coverVertical
        present(navVC, animated: true)
    }
    
    @objc func handleAppleLogin() {
        
        performAppleLogin()
    }
    
    @objc func handleGoogleLogin() {
        
        performGoogleLogin()
    }
    
    //MARK: - API
    
    func createUser(withEmail email: String, password: String, username: String, phone: String) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print("Failed to sign user with error: ", error.localizedDescription)
                return
            }
            
            else {
                
                // No Error. Store name
                let db = Firestore.firestore()
                
                db.collection("user").addDocument(data: ["firstname": username, "phone": phone, "email": email, "uid":result!.user.uid]) { (error) in
                    
                    if let error = error {
                        print("Failed to update database values with error: ", error.localizedDescription)
                        return
                    }
                
                }
                print("User Sign In")
                // Transition to home screen
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
                UserDefaults.standard.synchronize()
                
                let navVC = UINavigationController(rootViewController: SignUpController())
                navVC.modalPresentationStyle = .fullScreen
                //navVC.modalTransitionStyle = .coverVertical
                self.present(navVC, animated: false) {
                    navVC.pushViewController(TabBar(), animated: false)
                }
                
                
            }

        }
    }
    
    func performAppleLogin() {
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
    }
    
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        
        return request
    }
    
    func performGoogleLogin() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

          if let error = error {
            print("Field to login with google", error)
            return
          }

          guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                  let authError = error as NSError
                  if  authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                    // The user is a multi-factor user. Second factor challenge is required.
                    let resolver = authError
                      .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                    var displayNameString = ""
                    for tmpFactorInfo in resolver.hints {
                      displayNameString += tmpFactorInfo.displayName ?? ""
                      displayNameString += " "
                    }
                   
                  } else {
                   // self.showMessagePrompt(error.localizedDescription)
                      print("Error to login")
                    return
                  }
                  // ...
                  return
                }
                // User is signed in
                print(" User is signed in")

              
            }
            
            
            
            
            
            
            
            
        }
    }
    //MARK: - Helper Functions
    
    func configureViewComponents() {
        
        view.backgroundColor = UIColor.backgroundColor()
        navigationController?.navigationBar.isHidden = true
        
        
        view.addSubview(titleTextView)
        titleTextView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.topMargin.equalTo(15)
            make.leftMargin.equalTo(21)

        }
        
        view.addSubview(bodyTextView)
        bodyTextView.snp.makeConstraints { make in
            make.width.equalTo(321)
            make.height.equalTo(50)
            make.topMargin.equalTo(60)
            make.leftMargin.equalTo(21)
            
        }
        
        view.addSubview(nameContainerView)
        nameContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.topMargin.equalTo(120)
            make.leftMargin.equalTo(21)
 
        }
        
        view.addSubview(phoneContainerView)
        phoneContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.topMargin.equalTo(178)
            make.leftMargin.equalTo(21)

        }
        
        view.addSubview(emailContainerView)
        emailContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.topMargin.equalTo(236)
            make.leftMargin.equalTo(21)

        }

        view.addSubview(passwordContainerView)
        passwordContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.topMargin.equalTo(294)
            make.leftMargin.equalTo(21)
          
        }
        
        view.addSubview(rePasswordContainerView)
        rePasswordContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.topMargin.equalTo(352)
            make.leftMargin.equalTo(21)
        
        }

        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(44)
            make.leftMargin.equalTo(21)
            make.bottom.equalTo(-265)
        }

        view.addSubview(dontHaveAccount)
        dontHaveAccount.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(20)
            make.leftMargin.equalTo(86)
            make.bottom.equalTo(-231)
        }
        
        view.addSubview(seperator)
        seperator.snp.makeConstraints { make in
            make.width.equalTo(305)
            make.height.equalTo(19)
            make.leftMargin.equalTo(34)
            make.bottom.equalTo(-205)
        }
        
        view.addSubview(googleLoginButton)
        googleLoginButton.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(44)
            make.leftMargin.equalTo(21)
            make.bottom.equalTo(-89)
        }
    }
}


// MARK: Apple Extension
extension SignUpController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { (authDataResult, error) in
                if let user = authDataResult?.user {
                    print("Nice you have sign in as \(user.uid), email: \(user.email ?? " unknown")  ")
                }
            }
            
            
        }
    }
}

extension SignUpController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
private func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}

import CryptoKit

// Unhashed nonce.
fileprivate var currentNonce: String?

@available(iOS 13, *)
private func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}
