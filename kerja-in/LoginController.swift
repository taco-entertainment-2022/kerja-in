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

class LoginController: UIViewController {

    
    //MARK: - Properties
    lazy var titleTextView: UILabel = {
        let text = UILabel()
        return text.displayText(withPlaceholder: "Masuk", color: .black, isSecureTextEntry: false)
    }()
    
    lazy var bodyTextView: UILabel = {
        let text = UILabel()
        return text.displayText(withPlaceholder: "Masukkan alamat email dan password yang  telah didaftarkan", color: UIColor.placeHolderColor(),isSecureTextEntry: false)
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
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        return tf.textField(withPlaceholder: "Password", isSecureTextEntry: false)
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.buttonColor()
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    func appleLoginButton() {
        let button = ASAuthorizationAppleIDButton()
        //button.setTitle("Masuk menggunakan Apple", for: .normal)
        //button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        //button.setTitleColor(.white, for: .normal)
        //button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(handleAppleLogin), for: .touchUpInside)
        //button.layer.cornerRadius = 20
        button.center = view.center
        view.addSubview(button)
        button.anchor(top: seperator.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 330, height: 44)
        
        //return button
    }//()
    
    let googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Masuk menggunakan Google", for: .normal)
        button.setImage(UIImage(named: "google"), for: .normal)
        button.imageView?.anchor(top: nil, left: nil , bottom: nil, right: button.titleLabel?.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 4, width: 16, height: 16)
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
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
    
    let dontHaveAccount: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Belum memiliki akun? ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Daftar", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.black]))
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
        navigationController?.pushViewController(SignUpController(), animated: true)
    }
    
    //MARK: - API
    
    func logUserIn(withEmail email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                print("Failed to sign user in with error: ", error.localizedDescription)
                return
            }
            
            guard let navController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {return}
            guard let controller = navController.viewControllers[0] as? HomeController else {return}
            controller.configureViewComponents()
            print("Successfully logged user in...")
            self.dismiss(animated: true, completion: nil)

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
                
                
              
            }
            
            
            
            
            
            
            
            
        }
    }
    
    //MARK: - Helper Functions
    
    func configureViewComponents() {
        
        view.backgroundColor = UIColor.backgroundColor()
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(titleTextView)
        titleTextView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 62, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 50)
        
        view.addSubview(bodyTextView)
        bodyTextView.anchor(top: titleTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 30, paddingBottom: 0, paddingRight: 39, width: 0, height: 50)
        
        view.addSubview(emailContainerView)
        emailContainerView.anchor(top: bodyTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 50)

        view.addSubview(passwordContainerView)
        passwordContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 15, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 50)

        view.addSubview(loginButton)
        loginButton.anchor(top: passwordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 44)

        view.addSubview(dontHaveAccount)
        dontHaveAccount.anchor(top: loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 11, paddingLeft: 90, paddingBottom: 0, paddingRight: 90, width: 0, height: 50)

        view.addSubview(googleLoginButton)
        googleLoginButton.anchor(top: dontHaveAccount.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 98, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 44)

        view.addSubview(seperator)
        seperator.anchor(top: dontHaveAccount.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 7, paddingLeft: 42, paddingBottom: 0, paddingRight: 42, width: 305, height: 19)
        

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

    
