//
//  UserModel.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 09/10/22.
//

import Foundation
import UIKit

class JobModel {
    var userImage: UIImage?
    var jobName: String?
    var date: String?
    var location: String?
    var price: String?
    var posted: String?
    
    init(userImage: UIImage, jobName: String, date: String, location: String, price: String, posted: String) {
        self.userImage = userImage
        self.jobName = jobName
        self.date = date
        self.location = location
        self.price = price
        self.posted = posted
    }
}
