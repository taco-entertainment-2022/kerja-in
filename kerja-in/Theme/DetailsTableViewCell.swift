//
//  DetailsTableViewCell.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 16/10/22.
//

import UIKit
import SnapKit

class DetailsTableViewCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: 6, width: self.frame.width + 28, height: 20))
        view.backgroundColor = UIColor.red
        return view
    }()
    
    //MARK: - Static Label
  


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor(named: "White")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
