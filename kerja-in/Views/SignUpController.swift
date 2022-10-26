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
        button.setTitle("Daftar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.buttonColor()
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    let dontHaveAccount: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Sudah memiliki akun? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Masuk", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.black]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)

        return button
    }()
    
    let seperator: UIImageView = {
       
        let imageView = UIImageView()
        imageView.image = UIImage(named: "seperator")
        imageView.alpha = 0.87
        //view.addSubview(imageView)
        
        return imageView
    }()
    
    func appleLoginButton() {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(handleAppleLogin), for: .touchUpInside)
        button.center = view.center
        view.addSubview(button)
        //button.anchor(top: seperator.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 330, height: 44)
        button.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(44)
            //make.topMargin.equalTo(607)
            make.leftMargin.equalTo(21)
            //make.rightMargin.equalTo(-29)
            make.bottom.equalTo(-146)
        }
        
        //return button
    }//()
    
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
        //button.titleLabel?.anchor(top: nil, left: button.imageView?.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
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
    }
    
    //MARK: - Selectors
    
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
                //self.transitionToHome()
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
                UserDefaults.standard.synchronize()
                
                //self.present(TabBar(), animated: true)
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
                //self.navigationController?.pushViewController(JobsViewController(), animated: true)
                
                // go to google view controller
               // goToHome()
                
                
              
            }
            
            
            
            
            
            
            
            
        }
    }
    //MARK: - Helper Functions
    
    func configureViewComponents() {
        
        view.backgroundColor = UIColor.backgroundColor()
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(titleTextView)
        //titleTextView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 62, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 50)
        
        titleTextView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.topMargin.equalTo(15)
            make.leftMargin.equalTo(21)
            //make.rightMargin.equalTo(-261)
            //make.bottom.equalTo(-742)
        }
        
        view.addSubview(bodyTextView)
        //bodyTextView.anchor(top: titleTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 30, paddingBottom: 0, paddingRight: 39, width: 0, height: 50)
        
        bodyTextView.snp.makeConstraints { make in
            make.width.equalTo(321)
            make.height.equalTo(50)
            make.topMargin.equalTo(60)
            make.leftMargin.equalTo(21)
            //make.rightMargin.equalTo(-39)
            //make.bottom.equalTo(-697)
        }
        
        view.addSubview(nameContainerView)
        //nameContainerView.anchor(top: bodyTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 330, height: 43)
        
        nameContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.topMargin.equalTo(120)
            make.leftMargin.equalTo(21)
            //make.rightMargin.equalTo(-29)
            //make.bottom.equalTo(-634)
        }
        
        view.addSubview(phoneContainerView)
        //phoneContainerView.anchor(top: nameContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 330, height: 43)
        
        phoneContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.topMargin.equalTo(178)
            make.leftMargin.equalTo(21)
            //make.rightMargin.equalTo(-29)
            //make.bottom.equalTo(-576)
        }
        
        view.addSubview(emailContainerView)
        //emailContainerView.anchor(top: phoneContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 330, height: 43)
        
        emailContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.topMargin.equalTo(236)
            make.leftMargin.equalTo(21)
            //make.rightMargin.equalTo(-29)
            //make.bottom.equalTo(-518)
        }

        view.addSubview(passwordContainerView)
        //passwordContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 330, height: 43)
        
        passwordContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.topMargin.equalTo(294)
            make.leftMargin.equalTo(21)
            //make.rightMargin.equalTo(-29)
            //make.bottom.equalTo(-460)
        }
        
        view.addSubview(rePasswordContainerView)
        //rePasswordContainerView.anchor(top: passwordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 330, height: 43)
        
        rePasswordContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.topMargin.equalTo(352)
            make.leftMargin.equalTo(21)
            //make.rightMargin.equalTo(-29)
            //make.bottom.equalTo(-402)
        }

        view.addSubview(loginButton)
        //loginButton.anchor(top: rePasswordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 93, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 330, height: 44)
        
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(44)
            //make.topMargin.equalTo(488)
            make.leftMargin.equalTo(21)
            //make.rightMargin.equalTo(-29)
            make.bottom.equalTo(-265)
        }

        view.addSubview(dontHaveAccount)
        //dontHaveAccount.anchor(top: loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 14, paddingLeft: 90, paddingBottom: 0, paddingRight: 90, width: 0, height: 50)
        
        dontHaveAccount.snp.makeConstraints { make in
            make.width.equalTo(220)
            make.height.equalTo(20)
            //make.topMargin.equalTo(546)
            make.leftMargin.equalTo(86)
            //make.rightMargin.equalTo(-94)
            make.bottom.equalTo(-231)
        }
        
        view.addSubview(seperator)
        //seperator.anchor(top: dontHaveAccount.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 7, paddingLeft: 43, paddingBottom: 0, paddingRight: 41, width: 305, height: 19)
        
        seperator.snp.makeConstraints { make in
            make.width.equalTo(305)
            make.height.equalTo(19)
            //make.topMargin.equalTo(573)
            make.leftMargin.equalTo(34)
            //make.rightMargin.equalTo(-41)
            make.bottom.equalTo(-205)
        }
        
        view.addSubview(googleLoginButton)
        //googleLoginButton.anchor(top: seperator.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 72, paddingLeft: 30, paddingBottom: 89, paddingRight: 30, width: 330, height: 44)
        
        googleLoginButton.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(44)
            //make.topMargin.equalTo(664)
            make.leftMargin.equalTo(21)
            //make.rightMargin.equalTo(-29)
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
