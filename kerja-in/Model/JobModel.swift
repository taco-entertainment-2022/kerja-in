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
    var posted: String?
    var userName: String?
    var date: String?
    var duration: String?
    var location: String?
    var price: String?
    
    init(userImage: UIImage, jobName: String, posted: String, userName: String, date: String, duration: String, location: String, price: String) {
        self.userImage = userImage
        self.jobName = jobName
        self.posted = posted
        self.userName = userName
        self.date = date
        self.duration = duration
        self.location = location
        self.price = price
        
    }
}
