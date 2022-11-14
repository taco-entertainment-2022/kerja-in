//
//  OnboardingViewController.swift
//  kerja-in
//
//  Created by Wilbert Devin Wijaya on 02/11/22.
//

import UIKit

class OnboardingViewController: UIViewController {

    lazy var onboardingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Onboarding")
        
        return image
    }()
    
    lazy var backview: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "DarkWhite")

        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Selamat datang di Kerjain!"
        label.font = UIFont.Outfit(.semiBold, size: 32)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Kerjain membantu kamu mencari pekerjaan tanpa mengganggu jadwal kuliah."
        label.font = UIFont.Outfit(.regular, size: 18)
        label.textColor = UIColor(named: "DarkGray")
        label.numberOfLines = 0
        
        return label
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Daftar", for: .normal)
        button.titleLabel?.font = UIFont.Outfit(.medium, size: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.buttonColor()
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    let skipButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Lewati", attributes: [NSAttributedString.Key.font: UIFont.Outfit(.light, size: 16), NSAttributedString.Key.foregroundColor: UIColor.black])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(named: "DarkBlue")

        
        UserDefaults.standard.set(true, forKey: "onboarding")

        view.addSubview(onboardingImage)
        onboardingImage.snp.makeConstraints { make in
            make.width.equalTo(391)
            make.height.equalTo(281)
            make.top.equalTo(114)
            make.left.equalTo(14)
        }
 
        view.addSubview(backview)
        backview.snp.makeConstraints { make in
            make.top.equalTo(445)
            make.left.equalTo(0)
            make.right.equalTo(-0)
            make.bottom.equalTo(0)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(289)
            make.height.equalTo(82)
            make.bottom.equalTo(-279)
            make.left.equalTo(18)
            make.right.equalTo(-83)
        }
        
        view.addSubview(bodyLabel)
        bodyLabel.snp.makeConstraints { make in
            make.width.equalTo(336)
            make.height.equalTo(69)
            make.bottom.equalTo(-193)
            make.left.equalTo(19)
            make.right.equalTo(-35)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.bottom.equalTo(-78)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(-41)
            make.left.equalTo(169)
            make.right.equalTo(-169)
        }
    }
    

    @objc func handleShowSignUp() {
        let navVC = UINavigationController(rootViewController: OnboardingViewController())
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: false) {
            navVC.pushViewController(SignUpController(), animated: false)
        }
    }
    
    @objc func handleSkip() {
        let navVC = TabBar()
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: false)
    }
}
