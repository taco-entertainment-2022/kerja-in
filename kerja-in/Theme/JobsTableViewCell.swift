//
//  CustomTableViewCell.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 09/10/22.
//

import UIKit
import SnapKit

class JobsTableViewCell: UITableViewCell {
    
    var isOn: Bool = false
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 6, width: self.frame.width + 28, height: 81))
        view.backgroundColor = UIColor(named: "White")
        return view
    }()
    
    //MARK: - Image/Icon
    lazy var userImage: UIImageView = {
        let userImage = UIImageView(frame: CGRect(x: 12, y: 16, width: 59, height: 59))
        userImage.contentMode = .scaleAspectFill
        return userImage
    }()
    
    lazy var calendarIcon: UIImageView = {
        //let calendarIcon = UIImageView(frame: CGRect(x: 80, y: 37, width: 14, height: 14))
        let calendarIcon = UIImageView(frame: CGRect(x: 80, y: 39, width: 14, height: 14))
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
    lazy var jobLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 80, y: 8, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 16)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    
    lazy var dateLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 100, y: 31, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DarkGray")
        return lbl
    }()
    
    lazy var locationLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 240, y: 31, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DarkGray")
        return lbl
    }()
    
    lazy var priceLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 80, y: 53, width: backView.frame.width - 116, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.medium, size: 14)
        lbl.textColor = UIColor(named: "Black")
        return lbl
    }()
    
    lazy var postedLabel: UILabel = {
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
        
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = false

        //backView Shadow
        backView.layer.shadowColor = UIColor(named: "Black")?.cgColor
        backView.layer.shadowOpacity = 0.1
        backView.layer.shadowRadius = 6
        backView.layer.shadowOffset = CGSize(width: 1, height: 2)
        
        //Card constraint
        backView.snp.makeConstraints { make in
            make.left.equalTo(17)
            make.right.equalTo(-17)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
        
        //Saved buttom & posted constraint
        savedButton.snp.makeConstraints { make in
            make.topMargin.equalTo(12)
            make.rightMargin.equalTo(-12)
        }
        postedLabel.snp.makeConstraints { make in
            make.rightMargin.bottomMargin.equalTo(-12)
        }
        
        userImage.layer.cornerRadius = 10
        userImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(backView)
        backView.addSubview(userImage)
        backView.addSubview(jobLabel)
        backView.addSubview(dateLabel)
        backView.addSubview(calendarIcon)
        backView.addSubview(pinIcon)
        backView.addSubview(locationLabel)
        backView.addSubview(priceLabel)
        backView.addSubview(postedLabel)
        backView.addSubview(savedButton)
        
    }

}
