//
//  UserModel.swift
//  kerja-in
//
//  Created by Zidan Ramadhan on 09/10/22.
//

import Foundation
import UIKit

class JobModel {
    var postId: String?
    var jobImage: UIImage?
    var jobName: String?
    var posted: String?
    var userName: String?
    var date: String?
    var duration: String?
    var location: String?
    var price: String?
    var description: String?
    
    init(postId: String, userImage: UIImage, jobName: String, date: String, location: String, price: String, posted: String, description: String) {
        self.postId = postId
        self.jobImage = userImage
        self.jobName = jobName
        self.posted = posted
        self.userName = userName
        self.date = date
        self.duration = duration
        self.location = location
        self.price = price
        self.description = description
    }
}
