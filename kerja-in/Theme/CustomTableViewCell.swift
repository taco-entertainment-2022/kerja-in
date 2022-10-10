//
//  CustomTableViewCell.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 09/10/22.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    var isOn: Bool = false
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 6, width: self.frame.width + 28, height: 81))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    //MARK: - Image/Icon
    lazy var userImage: UIImageView = {
        let userImage = UIImageView(frame: CGRect(x: 12, y: 16, width: 59, height: 59))
        userImage.contentMode = .scaleAspectFill
        return userImage
    }()
    
    lazy var calendarIcon: UIImageView = {
        let calendarIcon = UIImageView(frame: CGRect(x: 80, y: 37, width: 19, height: 18))
        calendarIcon.image = UIImage(named: "Calendar")
        return calendarIcon
    }()
    
    lazy var pinIcon: UIImageView = {
        let pinIcon = UIImageView(frame: CGRect(x: 220, y: 37, width: 19, height: 19))
        pinIcon.image = UIImage(named: "Pin")
        return pinIcon
    }()
    
    //MARK: - Button
    lazy var savedButton: UIButton = {
        let savedButton = UIButton(frame: CGRect(x: 325, y: 16, width: 16, height: 18))
        savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        savedButton.tintColor = UIColor(named: "Black")
        savedButton.addTarget(self, action: #selector(savedButtonPressed(sender: )), for: .touchUpInside)
        return savedButton
    }()
    
    @objc func savedButtonPressed(sender: UIButton){
        print("Button Clicked")
        isOn.toggle()
        if isOn {
            savedButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        } else {
            savedButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    //MARK: - Label
    lazy var joblbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 80, y: 8, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 16)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    
    lazy var datelbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 105, y: 31, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DarkGray")
        return lbl
    }()
    
    lazy var locationlbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 240, y: 31, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DarkGray")
        return lbl
    }()
    
    lazy var pricelbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 80, y: 53, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 14)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    
    lazy var postedlbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 280, y: 56, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 12)
        lbl.textColor = UIColor(named: "Gray")
        return lbl
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
//        backView.layer.shadowColor = UIColor.black.cgColor
//        backView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        backView.layer.shadowOpacity = 1
//        backView.layer.shadowRadius = 5.0
        backView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
        
        userImage.layer.cornerRadius = 10
        userImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(userImage)
        backView.addSubview(joblbl)
        backView.addSubview(datelbl)
        backView.addSubview(calendarIcon)
        backView.addSubview(pinIcon)
        backView.addSubview(locationlbl)
        backView.addSubview(pricelbl)
        backView.addSubview(postedlbl)
        backView.addSubview(savedButton)
    }

}
