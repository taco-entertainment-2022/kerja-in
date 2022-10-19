//
//  DetailsTableViewCell.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 16/10/22.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    lazy var dateLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 105, y: 31, width: 30, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DarkGray")
        return lbl
    }()
    
    lazy var locationLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 240, y: 31, width: 30, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont.Outfit(.light, size: 14)
        lbl.textColor = UIColor(named: "DarkGray")
        return lbl
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
