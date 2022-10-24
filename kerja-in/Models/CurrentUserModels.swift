//
//  CurrentUser.swift
//  Kerjain-Login
//
//  Created by Wilbert Devin Wijaya on 17/10/22.
//

import Foundation

struct CurrentUser {
    let uid: String
    let name: String
    let email: String
    let phone: String
    //let profileImagegURL: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.name = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        //self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
    }
    
}
