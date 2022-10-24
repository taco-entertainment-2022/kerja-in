//
//  BookmarkModel.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 10/10/22.
//

import Foundation
import UIKit

class BookmarkModel {
    var userId: Int?
    var postId: Int?

    init(userId: Int? = nil, postId: Int? = nil) {
        self.userId = userId
        self.postId = postId
    }
}
