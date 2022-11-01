//
//  CheckboxButton.swift
//  kerja-in
//
//  Created by Wilbert Devin Wijaya on 27/10/22.
//

import UIKit

class CheckboxButton: UIView {
    
    var isChecked = false

    let checkmark: UIImageView = {
        let checkmark = UIImageView()
        checkmark.isHidden = true
        checkmark.contentMode = .scaleAspectFit
        checkmark.tintColor = .systemBlue
        checkmark.image = UIImage(systemName: "checkmark")
        
        return checkmark
    }()
    
    let boxView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.label.cgColor
        
        return view
    }()

    override init(frame: CGRect) {
        super.init (frame: frame)
        addSubview(boxView)
        addSubview(checkmark)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        boxView.frame = CGRect(x: 0, y:0, width: 15, height: 15)
        checkmark.frame = bounds
    }
    
    public func toggle() {
        self.isChecked = !isChecked
        
        checkmark.isHidden = !isChecked
    }
    
}
