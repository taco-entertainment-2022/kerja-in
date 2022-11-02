//
//  SettingTableViewCell.swift
//  profileSetting
//
//  Created by Wilbert Devin Wijaya on 22/10/22.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {

    static let identifier = "SettingTableViewCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        
        return view
    }()
    
//    private let iconImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.tintColor = .white
//        imageView.contentMode = .scaleAspectFit
//
//        return imageView
//    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        //label.font = UIFont.Outfit(.regular, size: 16)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
//        iconContainer.addSubview(iconImageView)

        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
//        let imageSize: CGFloat = size/1.5
//        iconImageView.frame = CGRect(x: (size-imageSize)/2, y: (size-imageSize)/2, width: imageSize, height: imageSize)
        
//        label.frame = CGRect(x: 25 + iconContainer.frame.size.width,
//                             y: 0,
//                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
//                             height: contentView.frame.size.height)
        label.frame = CGRect(x: 10,
                             y: 0,
                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                             height: contentView.frame.size.height)

        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        iconImageView.image = nil
        label.text = nil
//        iconContainer.backgroundColor = nil
    }
    
    public func configure(with model: SettingOption) {
        label.text = model.title
//        iconImageView.image = model.icon
//        iconContainer.backgroundColor = model.iconBackgroundColor
    }
    
}
