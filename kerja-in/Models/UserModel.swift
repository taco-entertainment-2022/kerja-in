//
//  UserModel.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 10/10/22.
//

import Foundation
import UIKit

class UserModel {
    var userId: String?
    var userImage: UIImage?
    var userName: String?
    var email: String?
    var password: String?
    var phone: String?
    
    init(userId: String, userImage: UIImage? = nil, userName: String? = nil, email: String? = nil, password: String? = nil, phone: String? = nil, jobPosts: String? = nil, savedJobs: String? = nil) {
        self.userId = userId
        self.userImage = userImage
        self.userName = userName
        self.email = email
        self.password = password
        self.phone = phone
    }
}

