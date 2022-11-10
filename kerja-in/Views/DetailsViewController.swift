//
//  DetailsViewController.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 11/10/22.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    
    
    var tableView = UITableView()
    var isOn: Bool = false
    let savedButton = UIButton(type: .custom)
    
    lazy var userImage: UIImageView = {
        let userImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 54, height: 54))
        userImage.contentMode = .scaleAspectFit
        return userImage
    }()
    lazy var jobLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 81, y: 8, width: view.frame.width, height: 25))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.semiBold, size: 20)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    lazy var daysLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 81, y: 31, width: view.frame.width, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DarkGray")
        return lbl
    }()
    lazy var divider1: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 1))
        view.backgroundColor = UIColor(named: "DividerGray")
        return view
    }()
    
    //MARK: - Details View
    lazy var detailsBackView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 6, width: 100, height: 100))
        view.backgroundColor = UIColor.clear
        return view
    }()
    lazy var timeLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: detailsBackView.frame.width + 15, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DetailsGray")
        lbl.text = "Waktu Pengerjaan"
        return lbl
    }()
    lazy var timeInfo: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 157, y: 0, width: detailsBackView.frame.width + 10, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 14)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    
    lazy var durationLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 32, width: detailsBackView.frame.width + 10, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DetailsGray")
        lbl.text = "Durasi"
        return lbl
    }()
    lazy var durationInfo: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 157, y: 32, width: detailsBackView.frame.width + 10, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 14)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    
    lazy var categoryLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 64, width: detailsBackView.frame.width + 10, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DetailsGray")
        lbl.text = "Kategori"
        return lbl
    }()
    lazy var categoryInfo: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 157, y: 64, width: detailsBackView.frame.width + 10, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 14)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    
    lazy var locationLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 96, width: detailsBackView.frame.width + 10, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DetailsGray")
        lbl.text = "Lokasi"
        return lbl
    }()
    lazy var locationInfo: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 157, y: 96, width: detailsBackView.frame.width + 10, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 14)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    
    lazy var paymentLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 128, width: detailsBackView.frame.width + 10, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DetailsGray")
        lbl.text = "Bayaran"
        return lbl
    }()
    lazy var paymentInfo: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 157, y: 128, width: detailsBackView.frame.width + 10, height: 18))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 14)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    
    lazy var divider2: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 1))
        view.backgroundColor = UIColor(named: "DividerGray")
        return view
    }()
    
    
    //MARK: - Bottom View
    lazy var descTitleLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 12.65))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 20)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    
    lazy var guideLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: detailsBackView.frame.width + 10, height: 16))
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var descLabel: UITextView = {
        let lbl = UITextView(frame: CGRect(x: 0, y: 0, width: 351, height: 273))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.regular, size: 14)
        lbl.textColor = UIColor(named: "DarkGray")
        lbl.backgroundColor = UIColor.clear
        lbl.isEditable = false
        lbl.isScrollEnabled = true
        lbl.isUserInteractionEnabled = true
        return lbl
    }()
    lazy var contactButton: UIButton = {
        let contactButton = UIButton(type: .system)
        contactButton.frame = CGRect(x: 0, y: 0, width: 350, height: 44)
        contactButton.setTitle("Kontak", for: .normal)
        contactButton.setImage(UIImage(named: "WhatsApp"), for: .normal)
        contactButton.imageView?.anchor(top: nil, left: nil , bottom: nil, right: contactButton.titleLabel?.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 20, height: 20)
        contactButton.imageView?.centerYAnchor.constraint(equalTo: contactButton.centerYAnchor).isActive = true
        
        contactButton.imageView?.centerYAnchor.constraint(equalTo: contactButton.centerYAnchor).isActive = true
        contactButton.titleLabel?.font = UIFont.Outfit(.medium, size: 20)
        contactButton.setTitleColor(.white, for: .normal)
        contactButton.tintColor = UIColor(named: "White")
        contactButton.backgroundColor = UIColor(named: "Green")
        contactButton.layer.cornerRadius = contactButton.frame.height / 2
        contactButton.addTarget(self, action: #selector(contactButtonPressed), for: .touchUpInside)
        contactButton.titleLabel?.centerYAnchor.constraint(equalTo: contactButton.centerYAnchor).isActive = true
        
        contactButton.layer.shadowColor = UIColor(named: "Black")?.cgColor
        contactButton.layer.shadowOpacity = 0.2
        contactButton.layer.shadowRadius = 6
        contactButton.layer.shadowOffset = CGSize(width: 1, height: 2)
        return contactButton
    }()
    
    @objc func contactButtonPressed(sender: UIButton) {
        let appURL = URL(string: "https://wa.me/\(contactData)?text=Halo,%20saya%20ingin%20tahu%20lebih%20lanjut%20mengenai%20postingan%20kamu%20di%20kerjain")!
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL)
            }
        }
    }
    
    var jobData: String = "Interview Mahasiswa Rantau"
    var timeData: String = "Senin, 9 Oct 2022"
    var categoryData = UIImage(named: "Riset")
    var durationData: String = "15 Menit"
    var locationData: String = "Online"
    var paymentData: String = "Rp5.000"
    var descriptionData: String = "Butuh respondent mahasiswa rantau ya... Wajib lapor sebelum ngisi respondent. Tujuannya supaya bisa konfirmasi dulu dan bisa dibayar. Hubungi WAnya yang tertera ya. \n\nKalau bisa mahasiswa rantau dari luar Jawa ya... terus baru menjalani kuliah semester2 awal."
    var contactData: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "DarkWhite")
        
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.Outfit(.semiBold, size: 20)]
        appearance.backgroundColor = UIColor(named: "DarkBlue")
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        //Navigation Bar
        self.title = "Job Detail"
        savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        savedButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        savedButton.addTarget(self, action: #selector(savedButtonPressed), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: savedButton)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        //MARK: - Upper
        userImage.image = categoryData
        jobLabel.text = jobData
        daysLabel.text = "5 days ago, oleh Fredo Sembi"
        
        
        //MARK: - Details Text
        timeInfo.text = timeData
        durationInfo.text = durationData
        
        if categoryData == UIImage(named: "Responden") {
            categoryInfo.text = "Responden"
        } else if categoryData == UIImage(named: "Jasa Setir") {
            categoryInfo.text = "Jasa Setir"
        } else if categoryData == UIImage(named: "Titip Beli") {
            categoryInfo.text = "Titip Beli"
        } else if categoryData == UIImage(named: "Foto Model") {
            categoryInfo.text = "Foto Model"
        } else if categoryData == UIImage(named: "Sales") {
            categoryInfo.text = "Sales"
        } else if categoryData == UIImage(named: "MC") {
            categoryInfo.text = "MC"
        } else if categoryData == UIImage(named: "Riset") {
            categoryInfo.text = "Riset"
        } else {
            categoryInfo.text = "Lainnya"
        }
         
        locationInfo.text = locationData
        paymentInfo.text = paymentData
        
        //MARK: - Lower
        descTitleLabel.text = "Deskripsi Pekerjaan"
        descLabel.text = descriptionData


        //Guide Label
        let lightFontAttributes = [NSAttributedString.Key.font : UIFont.Outfit(.light, size: 13), NSAttributedString.Key.foregroundColor : UIColor(named: "GuideGray")]
        let boldFontAttributes = [NSAttributedString.Key.font : UIFont.Outfit(.semiBold, size: 13), NSAttributedString.Key.foregroundColor : UIColor(named: "GuideGray")]
        
        let guideString1 = NSMutableAttributedString(string: "Tekan tombol di atas untuk", attributes: lightFontAttributes)
        let guideString2 = NSMutableAttributedString(string: " bertanya", attributes: boldFontAttributes)
        let guideString3 = NSMutableAttributedString(string: " atau", attributes: lightFontAttributes)
        let guideString4 = NSMutableAttributedString(string: " mendaftar.", attributes: boldFontAttributes)
        
        guideString1.append(guideString2)
        guideString1.append(guideString3)
        guideString1.append(guideString4)
        self.guideLabel.attributedText = guideString1
        
        setupViews()
    }
    
    @objc func savedButtonPressed() {
        print("Button Clicked")
        isOn.toggle()
        if isOn {
            savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    func setupViews() {
        self.view.addSubview(userImage)
        self.view.addSubview(jobLabel)
        self.view.addSubview(daysLabel)
        self.view.addSubview(divider1)
        
        self.view.addSubview(descTitleLabel)
        self.view.addSubview(descLabel)
        self.view.addSubview(contactButton)
        self.view.addSubview(guideLabel)

        
        self.view.addSubview(detailsBackView)
        detailsBackView.addSubview(timeLabel)
        detailsBackView.addSubview(timeInfo)
        detailsBackView.addSubview(durationLabel)
        detailsBackView.addSubview(durationInfo)
        detailsBackView.addSubview(categoryLabel)
        detailsBackView.addSubview(categoryInfo)
        detailsBackView.addSubview(locationLabel)
        detailsBackView.addSubview(locationInfo)
        detailsBackView.addSubview(paymentLabel)
        detailsBackView.addSubview(paymentInfo)
        self.view.addSubview(divider2)
        
        //Set constraints
        userImage.snp.makeConstraints { make in
            make.topMargin.equalTo(17)
            make.left.equalTo(17)
            make.width.height.equalTo(54)
        }
        jobLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(25)
            make.topMargin.equalTo(25)
            make.leftMargin.equalTo(73)
        }
        daysLabel.snp.makeConstraints { make in
            make.width.equalTo(188)
            make.height.equalTo(18)
            make.topMargin.equalTo(48)
            make.leftMargin.equalTo(73)
        }
        divider1.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(1)
            make.left.equalTo(17)
            make.topMargin.equalTo(85)
            make.right.equalTo(-17)
        }
        
        detailsBackView.snp.makeConstraints { make in
            make.topMargin.equalTo(100)
            make.bottomMargin.equalTo(-435)
            make.left.equalTo(17)
            make.right.equalTo(-17)
        }
        divider2.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(1)
            make.left.equalTo(17)
            make.topMargin.equalTo(260)
            make.right.equalTo(-17)
        }
        
        descTitleLabel.snp.makeConstraints { make in
            make.width.equalTo(239)
            make.height.equalTo(25)
            make.topMargin.equalTo(270)
            make.left.equalTo(15)
        }
        descLabel.snp.makeConstraints { make in
            make.width.equalTo(351)
            make.height.equalTo(273)
            make.topMargin.equalTo(300)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        contactButton.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(44)
            make.topMargin.equalTo(620)
            make.left.equalTo(17)
            make.right.equalTo(-17)
            make.bottom.equalTo(-40)
        }
        guideLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-14)
            make.left.equalTo(17)
            make.right.equalTo(-17)
        }
    }
    
}
