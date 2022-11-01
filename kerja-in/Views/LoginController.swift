//
//  LoginController.swift
//  Kerjain-Login
//
//  Created by Wilbert Devin Wijaya on 04/10/22.
//

import UIKit
import Firebase
import AuthenticationServices
import GoogleSignIn
import FirebaseAuth

class LoginController: UIViewController {

    
    //MARK: - Properties
    lazy var titleTextView: UILabel = {
        let text = UILabel()
        text.font = UIFont.Outfit(.semiBold, size: 32)

        return text.displayText(withPlaceholder: "Masuk", font: UIFont.Outfit(.semiBold, size: 32), color: .black, isSecureTextEntry: false)
    }()
    
    lazy var bodyTextView: UILabel = {
        let text = UILabel()
        return text.displayText(withPlaceholder: "Masukkan alamat email dan password yang  telah didaftarkan", font: UIFont.Outfit(.light, size: 16), color: UIColor.placeHolderColor(),isSecureTextEntry: false)
    }()
    
    lazy var emailContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, emailTextField)
        
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, passwordTextField)
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
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Outfit(.regular, size: 14)
        label.textAlignment = .left
        label.text = "Error"
        label.textColor = UIColor.systemRed
        label.numberOfLines = 0
        label.alpha = 0
        
        return label
    }()
    
    
    let seperator: UIImageView = {
       
        let imageView = UIImageView()
        imageView.image = UIImage(named: "seperator")
        imageView.alpha = 0.87
        //view.addSubview(imageView)
        
        return imageView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Masuk", for: .normal)
        button.titleLabel?.font = UIFont.Outfit(.medium, size: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.buttonColor()
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.layer.cornerRadius = 20
        
        return button
    }()

    
    func appleLoginButton() {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(handleAppleLogin), for: .touchUpInside)
        button.center = view.center
        view.addSubview(button)
        
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(44)
            make.top.equalTo(424)
            make.leftMargin.equalTo(21)
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
    
    let dontHaveAccount: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Belum memiliki akun? ", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.light, size: 16), NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Daftar", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.medium, size: 16), NSAttributedString.Key.foregroundColor: UIColor.black]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureViewComponents()
        appleLoginButton()
        
        
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
    
    
    @objc func handleLogin() {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        logUserIn(withEmail: email, password: password)
    }
    
    @objc func handleAppleLogin() {
        
        performAppleLogin()
    }
    
    @objc func handleGoogleLogin() {
        
        performGoogleLogin()
    }
    
    @objc func handleShowSignUp() {
        let navVC = UINavigationController(rootViewController: SignUpController())
        navVC.modalPresentationStyle = .fullScreen
        navVC.modalTransitionStyle = .coverVertical
        present(navVC, animated: true)
    }
    
    
    //MARK: - API
    
    func logUserIn(withEmail email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    self.errorLabel.text =  "The email is already in use with another account"
                    self.errorLabel.alpha = 1
                    
                
                case AuthErrorCode.userNotFound.rawValue:
                    self.errorLabel.text = "Account not found for the specified us er. Please check and try again"
                    self.errorLabel.alpha = 1

                case AuthErrorCode.userDisabled.rawValue:
                    self.errorLabel.text = "Your account has been disabled. Please contact support."
                    self.errorLabel.alpha = 1

                case AuthErrorCode.invalidEmail.rawValue, AuthErrorCode.invalidSender.rawValue, AuthErrorCode.invalidRecipientEmail.rawValue:
                    self.errorLabel.text = "Please enter a valid email"
                    self.errorLabel.alpha = 1

                case AuthErrorCode.networkError.rawValue:
                    self.errorLabel.text = "Network error. Please try again."
                    self.errorLabel.alpha = 1

                case AuthErrorCode.weakPassword.rawValue:
                    self.errorLabel.text = "Your password is too weak. The password must be 6 characters long or more."
                    self.errorLabel.alpha = 1

                case AuthErrorCode.wrongPassword.rawValue:
                    self.errorLabel.text = "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
                    self.errorLabel.alpha = 1

                default:
                    self.errorLabel.text = "Unknown error occurred"
                    self.errorLabel.alpha = 1

                    
                }
                
                return
                
            }

            print("Successfully logged user in...")
            
            UserDefaults.standard.set(true, forKey: "userLoggedIn")
            UserDefaults.standard.synchronize()
            
            let navVC = UINavigationController(rootViewController: LoginController())
            navVC.modalPresentationStyle = .fullScreen
            //navVC.modalTransitionStyle = .coverVertical
            self.present(navVC, animated: false) {
                navVC.pushViewController(TabBar(), animated: false)
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
                
                // go to google view controller
               // goToHome()
                
                //MARK: Store Google Data to Firestore
                let db = Firestore.firestore()
 
                let googleEmail = (authResult?.user.email)!
                let googleName = (authResult?.user.displayName)!
                
                db.collection("user").document(String(authResult!.user.uid)).setData([
                    "firstname": String(googleName),
                    "email": String(googleEmail)], merge: true)
                
                UserDefaults.standard.set(true, forKey: "userLoggedIn")
                UserDefaults.standard.synchronize()
                
                let navVC = UINavigationController(rootViewController: LoginController())
                navVC.modalPresentationStyle = .fullScreen
                //navVC.modalTransitionStyle = .coverVertical
                self.present(navVC, animated: false) {
                    navVC.pushViewController(TabBar(), animated: false)
                }
                
              
            }
            
        }
    }
    
    //MARK: - Helper Functions
    
    func configureViewComponents() {
        
        view.backgroundColor = UIColor.backgroundColor()
        navigationController?.navigationBar.isHidden = true
        

        view.addSubview(titleTextView)
        titleTextView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(44)
            make.top.equalTo(62)
            make.leftMargin.equalTo(21)
        }
        
        view.addSubview(bodyTextView)
        bodyTextView.snp.makeConstraints { make in
            make.width.equalTo(321)
            make.height.equalTo(42)
            make.top.equalTo(107)
            make.leftMargin.equalTo(21)
        }
        
        view.addSubview(emailContainerView)
        emailContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.top.equalTo(167)
            make.leftMargin.equalTo(21)
        }

        view.addSubview(passwordContainerView)
        passwordContainerView.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(43)
            make.top.equalTo(225)
            make.leftMargin.equalTo(21)
        }

        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(44)
            make.top.equalTo(308)
            make.leftMargin.equalTo(21)
        }

        view.addSubview(dontHaveAccount)
        dontHaveAccount.snp.makeConstraints { make in
            make.width.equalTo(202)
            make.height.equalTo(20)
            make.top.equalTo(363)
            make.leftMargin.equalTo(85)
        }

        view.addSubview(seperator)
        seperator.snp.makeConstraints { make in
            make.width.equalTo(305)
            make.height.equalTo(19)
            make.top.equalTo(390)
            make.leftMargin.equalTo(34)
        }
        
        view.addSubview(googleLoginButton)
        googleLoginButton.snp.makeConstraints { make in
            make.width.equalTo(330)
            make.height.equalTo(44)
            make.top.equalTo(481)
            make.leftMargin.equalTo(21)
        }
        
        view.addSubview(errorLabel)        
        errorLabel.snp.makeConstraints { make in
            make.width.equalTo(254)
            make.height.equalTo(18)
            make.top.equalTo(280)
            make.leftMargin.equalTo(59)
        }
          
    }
}

// MARK: Apple Extension
extension LoginController: ASAuthorizationControllerDelegate {
    
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
                    
                    //MARK: Store Data to Firestore
                    let db = Firestore.firestore()
                    
                    db.collection("user").document(user.uid).setData([
                        "firstname": user.displayName as? String,
                        "email": user.email as? String], merge: true)
                    
                    UserDefaults.standard.set(true, forKey: "userLoggedIn")
                    UserDefaults.standard.synchronize()
                    
                    let navVC = UINavigationController(rootViewController: LoginController())
                    navVC.modalPresentationStyle = .fullScreen
                    //navVC.modalTransitionStyle = .coverVertical
                    self.present(navVC, animated: false) {
                        navVC.pushViewController(TabBar(), animated: false)
                    }
                }
            }
        }
    }
}

extension LoginController: ASAuthorizationControllerPresentationContextProviding {
    
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

extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case AuthErrorCode.emailAlreadyInUse:
            return "The email is already in use with another account"
        case AuthErrorCode.userNotFound:
            return "Account not found for the specified us er. Please check and try again"
        case AuthErrorCode.userDisabled:
            return "Your account has been disabled. Please contact support."
        case AuthErrorCode.invalidEmail, AuthErrorCode.invalidSender, AuthErrorCode.invalidRecipientEmail:
            return "Please enter a valid email"
        case AuthErrorCode.networkError:
            return "Network error. Please try again."
        case AuthErrorCode.weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case AuthErrorCode.wrongPassword:
            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
        default:
            return "Unknown error occurred"
        }
    }
}
