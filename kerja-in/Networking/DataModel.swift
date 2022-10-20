//
//  DataModel.swift
//  kerja-in
//
//  Created by Sherary Apriliana on 12/10/22.
//

/**
User UID <uid> String: {
        profile: {
            name: <email> String
            password: <password> String
            username: <username> String
            phone: <phone> String
            userImage: <userImage> String
        }
                
        posts: {
            postId: <postId> Int {
                 jobImage: <jobImage> String
                 jobName: <jobName> String
                 date: <date> String
                 location: <location> String
                 price: <price> String
                 posted: <posted> String
                 description: <description> String
            }
            .....
        }
 
        bookmarked: {
            postId: <postId> Int {
                jobImage: <jobImage> String
                jobName: <jobName> String
                date: <date> String
                location: <location> String
                price: <price> String
                posted: <posted> String
                description: <description> String
            }
            .....
        }
    }
 
 */

import Foundation
import Firebase

//var ref: DatabaseReference!
//
//class DataModel {
//    func createPost(postID: Int, value: JobModel) {
//        ref = Database.database().reference()
////        self.ref.child(postID).setValue(value)
//    }
//}
